Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8245B4AE7A7
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 04:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbiBIDI1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Feb 2022 22:08:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344798AbiBIDFf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Feb 2022 22:05:35 -0500
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91DCC03C18A;
        Tue,  8 Feb 2022 19:04:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1644375853; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=WorCt5jMIySyHwJfpNSzz2BrXyZMXUwt92IZ1gNlXewwjXjQXVwD5CZppyeHzpVk7fqUKWaGVQ7sIEsxk/N2LPnEGpABCF6Blf9w7INLGPZ1PEcBmTKk6DU0cbj3XQRReJjHjicwh7Uugy+dqLA9V63Mvmf6p6mwKv4/YayVlLg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1644375853; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=BpG9nWuqxCMxY1RFXW3C20VB8eyjs61dDPVCp5q83Cs=; 
        b=M0SjkpxK4vfQ8c+oHa7pBmsHdjV3D7Vg8VjJSEzhdtUrmiMaiPgUxP+HT8My+S/4wJ5S/o0y8hJRQh5EXA1DdLKqn5cmiUhsAZt5Ld7vyPdjc0AoxlZqqbAr6L4mtMGX+lHTvywMZGgJiwVUXN+erZV4qFZWNTGsmTrslQBuPSY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1644375853;
        s=zm2020; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=BpG9nWuqxCMxY1RFXW3C20VB8eyjs61dDPVCp5q83Cs=;
        b=Zut0zbRALsGiiLnSOS1fNPAHp52g5ifop74/Ol10NkX52UO8/vXLPdGrBaumu8hL
        dz5OI5i1YnqXfGMq7mjjeDnqlPcFdYxzVOkagYGCIeGRyg9JCgsc93ayDcmpXyvOIcA
        HVpyf9ZVy76az0bwz72yy6z5XneLGAIbHGLii5C8=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1644375851138653.9630815206081; Tue, 8 Feb 2022 19:04:11 -0800 (PST)
Received: from  [40.115.208.189] by mail.zoho.com
        with HTTP;Tue, 8 Feb 2022 19:04:11 -0800 (PST)
Date:   Tue, 08 Feb 2022 22:04:11 -0500
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Kishon Vijay Abraham I" <kishon@ti.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-pci" <linux-pci@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17edc704068.b7a8b7fd15807.1121272585658152695@zohomail.com>
In-Reply-To: <17e7ad65ff5.d9de88b4962.1109678039880040918@zohomail.com>
References: <17e7ad65ff5.d9de88b4962.1109678039880040918@zohomail.com>
Subject: Re: [PATCH v4] PCI: endpoint: Add prefetch BAR support
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ping. 

PS: this patch can be git am on 5.17-rc3 without confliction.

 ---- On Thu, 20 Jan 2022 23:12:56 -0500 Li Chen <lchen.firstlove@zohomail.com> wrote ----
 > From: Li Chen <lchen@ambarella.com>
 > 
 > Before this commit, epf cannot set BAR to be prefetchable.
 > Prefetchable BAR can also help epf device to use bridge's
 > prefetch memory window.
 > 
 > Signed-off-by: Li Chen <lchen@ambarella.com>
 > ---
 > Changes in v2:
 > Remove Gerrit Change-id
 > Changes in v3:
 > capitalize "BAR" in the subject and commit log as suggested by Bjorn.
 > Changes in v4:
 > This patch context doesn't change but resend with my Zoho mail account in that previous
 > company mail will contain un-removeable proprietary messages. 
 > Add "From:" to the first line of the message body.
 > 
 >  drivers/pci/endpoint/functions/pci-epf-test.c | 4 ++++
 >  include/linux/pci-epc.h                       | 2 ++
 >  2 files changed, 6 insertions(+)
 > 
 > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
 > index 90d84d3bc868..96489cfdf58d 100644
 > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
 > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
 > @@ -817,15 +817,19 @@ static void pci_epf_configure_bar(struct pci_epf *epf,
 >  {
 >      struct pci_epf_bar *epf_bar;
 >      bool bar_fixed_64bit;
 > +    bool bar_prefetch;
 >      int i;
 >  
 >      for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 >          epf_bar = &epf->bar[i];
 >          bar_fixed_64bit = !!(epc_features->bar_fixed_64bit & (1 << i));
 > +        bar_prefetch = !!(epc_features->bar_prefetch & (1 << i));
 >          if (bar_fixed_64bit)
 >              epf_bar->flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
 >          if (epc_features->bar_fixed_size[i])
 >              bar_size[i] = epc_features->bar_fixed_size[i];
 > +        if (bar_prefetch)
 > +            epf_bar->flags |= PCI_BASE_ADDRESS_MEM_PREFETCH;
 >      }
 >  }
 >  
 > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
 > index a48778e1a4ee..825632d581d0 100644
 > --- a/include/linux/pci-epc.h
 > +++ b/include/linux/pci-epc.h
 > @@ -161,6 +161,7 @@ struct pci_epc {
 >   * @msix_capable: indicate if the endpoint function has MSI-X capability
 >   * @reserved_bar: bitmap to indicate reserved BAR unavailable to function driver
 >   * @bar_fixed_64bit: bitmap to indicate fixed 64bit BARs
 > + * @bar_prefetch: bitmap to indicate prefetchable BARs
 >   * @bar_fixed_size: Array specifying the size supported by each BAR
 >   * @align: alignment size required for BAR buffer allocation
 >   */
 > @@ -171,6 +172,7 @@ struct pci_epc_features {
 >      unsigned int    msix_capable : 1;
 >      u8    reserved_bar;
 >      u8    bar_fixed_64bit;
 > +    u8    bar_prefetch;
 >      u64    bar_fixed_size[PCI_STD_NUM_BARS];
 >      size_t    align;
 >  };
 > -- 
 > 2.34.1
 > 
 > 
 > 
