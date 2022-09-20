Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBB25BEE3B
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 22:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiITUI3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 16:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiITUI2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 16:08:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D1B61715;
        Tue, 20 Sep 2022 13:08:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1678B82B9B;
        Tue, 20 Sep 2022 20:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63ED4C433C1;
        Tue, 20 Sep 2022 20:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663704505;
        bh=EUY9QLDoCjnVdfic7qGUwsLuF2PNMJt8mQoH55CpI6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bBP65CTFsPPM/CaUcKWcPLqhxwtCccCQSx4ullSjIfuxEKLPoPNJ6+YRRP64gASu9
         iBk2Ni2SEmxyucw3W4oelAibrHEfRT2U3yfHNWrVteTAEMCbxK/qB2LKCWm0Antwgd
         58IJjwuBkQv0DTOinjxCCxvevhV6j+X3W55ZEfLuukWaXQZKP+e5FojmvCVeDfo4cs
         lBzxVdunEkruzUxKllavVhL5nK82AxzqGnhqWXTJgLvQFsj46rvNqHlf898enVUOGe
         3JSNikWo7NvGlUlVgzwEVj0aVlhRzb7m7CaQN4JffQiL/Nnz42k7j9a//fDTfi+wEY
         TIPsPYm4g3bXg==
Date:   Tue, 20 Sep 2022 15:08:23 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org, geert+renesas@glider.be,
        magnus.damm@gmail.com, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v5 03/12] PCI: Add PCI_EXP_LNKCAP_MLW macros
Message-ID: <20220920200823.GA1134038@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905071257.1059436-4-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 05, 2022 at 04:12:48PM +0900, Yoshihiro Shimoda wrote:
> Add macros defining Maximum Link Width bits in Link Capabilities
> Register.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  include/uapi/linux/pci_regs.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 57b8e2ffb1dd..c9f4c452e210 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -538,6 +538,13 @@
>  #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit 3 */
>  #define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bit 4 */
>  #define  PCI_EXP_LNKCAP_SLS_64_0GB 0x00000006 /* LNKCAP2 SLS Vector bit 5 */
> +#define  PCI_EXP_LNKCAP_MLW_X1	0x00000010 /* Maximum Link Width x1 */
> +#define  PCI_EXP_LNKCAP_MLW_X2	0x00000020 /* Maximum Link Width x2 */
> +#define  PCI_EXP_LNKCAP_MLW_X4	0x00000040 /* Maximum Link Width x4 */
> +#define  PCI_EXP_LNKCAP_MLW_X8	0x00000080 /* Maximum Link Width x8 */
> +#define  PCI_EXP_LNKCAP_MLW_X12	0x000000c0 /* Maximum Link Width x12 */
> +#define  PCI_EXP_LNKCAP_MLW_X16	0x00000100 /* Maximum Link Width x16 */
> +#define  PCI_EXP_LNKCAP_MLW_X32	0x00000200 /* Maximum Link Width x32 */

In PCIe r6.0, x32 is mentioned a few times, but not actually defined
for Link Capabilities.  Has it been defined in an ECN or something?

Bjorn
