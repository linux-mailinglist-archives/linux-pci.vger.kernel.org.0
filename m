Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8CB570B48
	for <lists+linux-pci@lfdr.de>; Mon, 11 Jul 2022 22:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiGKUXz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 16:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGKUXx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 16:23:53 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C24820BDE
        for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2022 13:23:51 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 08F25104AA2ED;
        Mon, 11 Jul 2022 22:23:49 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id D995C2ED3F0; Mon, 11 Jul 2022 22:23:48 +0200 (CEST)
Date:   Mon, 11 Jul 2022 22:23:48 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Paul Luse <paul.e.luse@intel.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        Jing Liu <jing2.liu@intel.com>
Subject: Re: [PATCH v6] PCI: Add save and restore capability for TPH config
 space
Message-ID: <20220711202348.GB31003@wunner.de>
References: <20220708140733.3582-1-paul.e.luse@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708140733.3582-1-paul.e.luse@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 08, 2022 at 10:07:33AM -0400, Paul Luse wrote:
> +void pci_save_tph_state(struct pci_dev *dev)
> +{
> +	struct pci_cap_saved_state *save_state;
> +	int num_entries, i, offset;
> +	u16 *st_entry, tph;
> +	u32 *cap;
> +
> +	tph = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_TPH);
> +	if (!tph)
> +		return;
> +
> +	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_TPH);
> +	if (!save_state)
> +		return;
> +
> +	/* Save control register as well as all ST entries */
> +	cap = &save_state->cap.data[0];
> +	pci_read_config_dword(dev, tph + PCI_TPH_CTL, cap++);
> +	st_entry = (u16 *)cap;
> +	offset = PCI_TPH_ST_TBL;
> +	num_entries = pci_get_tph_st_num_entries(dev, tph);
> +	for (i = 0; i < num_entries; i++) {
> +		pci_read_config_word(dev, tph + offset, st_entry++);
> +		offset += sizeof(u16);
> +	}
> +}

It has just occurred to me that a small optimization would be possible here:

	num_entries = save_state->cap.size - sizeof(u32);

Though your approach is probably more readable.


> +void pci_tph_init(struct pci_dev *dev)
> +{
> +	int num_entries;
> +	u32 save_size;
> +	u16 tph;
> +
> +	if (!pci_is_pcie(dev))
> +		return;
> +
> +	tph = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_TPH);
> +	if (!tph)
> +		return;
> +
> +	num_entries = pci_get_tph_st_num_entries(dev, tph);
> +	save_size = sizeof(int) + num_entries * sizeof(u16);
> +	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_TPH, save_size);
> +}

sizeof(u32) instead of sizeof(int) is probably more appropriate to account
for the Control register.  I can never remember if sizeof(int) is 4 or 8
on a 64-bit architecture, but I guess it's 4.

Either way, this is
Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks,

Lukas
