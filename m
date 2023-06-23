Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC5A73BF48
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jun 2023 22:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjFWUPE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jun 2023 16:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjFWUPC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jun 2023 16:15:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960C82721;
        Fri, 23 Jun 2023 13:15:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B50A619EF;
        Fri, 23 Jun 2023 20:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C10C433C0;
        Fri, 23 Jun 2023 20:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687551300;
        bh=cBdOmzREH23gQr5BLoIgKLXYX1NGEsq6gM/x9nbKeJA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NSmPbphvqssng0ETNLPI8H7XtPiIAsT3lZTFpnU8blIbBjO+d1xLZgXWqS8jf6mqo
         ZnZkoGIgh49/FAbKjkQg7T1BokS06BCe+EavA4tMKOVSUI2Lub4tVyJR8khoDNdRwD
         d8aly1z5KAqgB/9hMH7Uy1sYXWa3UorUNGuwig2yqUEB6aNihq0A7RNFDWtUZXRoCD
         79m3T1O8pe3TU48eh1KUxPBSvsjmAlvuPaWx+/J6724D9NW5/juV2i7U0E1Z+hVdul
         GCad2nA1sT4b/vdch39iHd+FePWdd/ZhPJV43HcLvkJDSCzMIbx1K7SDwfLC0tES0V
         dPxv6Hsp+hsWw==
Date:   Fri, 23 Jun 2023 15:14:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dlemoal@kernel.org
Subject: Re: [PATCH v6 2/9] PCI: endpoint: Pass EPF device ID to the probe
 function
Message-ID: <20230623201458.GA201342@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602114756.36586-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 02, 2023 at 05:17:49PM +0530, Manivannan Sadhasivam wrote:
> Currently, the EPF probe function doesn't get the device ID argument needed
> to correctly identify the device table ID of the EPF device.
> ...

> +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> @@ -2075,11 +2075,12 @@ static struct config_group *epf_ntb_add_cfs(struct pci_epf *epf,
>  /**
>   * epf_ntb_probe() - Probe NTB function driver
>   * @epf: NTB endpoint function device
> + * @id: NTB endpoint function device ID
>   *
>   * Probe NTB function driver when endpoint function bus detects a NTB
>   * endpoint function.
>   */
> -static int epf_ntb_probe(struct pci_epf *epf)
> +static int epf_ntb_probe(struct pci_epf *epf, const struct pci_epf_device_id *id)
> ...

> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1401,7 +1401,7 @@ static struct pci_epf_ops epf_ntb_ops = {

>   *
>   * Returns: Zero for success, or an error code in case of failure
>   */
> -static int epf_ntb_probe(struct pci_epf *epf)
> +static int epf_ntb_probe(struct pci_epf *epf, const struct pci_epf_device_id *id)

I updated the pci/endpoint branch to add kernel-doc for the new "id",
same as you did in pci-epf-ntb.c.

Just FYI, Lorenzo & Krzysztof -- hopefully there are no more updates
before the merge window, but if you do add anything to this branch,
update it first.

Bjorn
