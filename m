Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214607C5148
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 13:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjJKLOQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 07:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345946AbjJKLNy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 07:13:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A86A7;
        Wed, 11 Oct 2023 04:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697022832; x=1728558832;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xK0A3ZPFrBwBH4wbgA1N2zR+vxm9xV/YSO4h8dRP8w8=;
  b=KZEuCn9JiC5cdVrntkQrnSNj8cQeWq6HC4PcLD6znvqSL4bk3LG4Z2Sf
   BEVRHI4aGwQ4M6deOkeP71IFH7oFkgbTsLYr+cXw+OKBYptf/G92auyzg
   2tkxJL9gVBZmc+T6dD1u585UDtukNjNHVua9hZjCJzgqzmlH1DpTsfR2r
   yBll1zy/b6rbgRWcWJQcY/OHWmTDbgVvZLcf1S0SWgpMPiBGK08hIn6K7
   2wt9bQszrujy2/74g3Hnq8KQ+QeOx7IumlKABXTZkq7K4xjsL0yUX01q7
   WP3N/boDUub9iVo5Szm7VKbUDGT0phYmXZEoFC/viGY4ucyR/TmQQZLfo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="363996350"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="363996350"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:13:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="824120137"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="824120137"
Received: from opipikin-mobl2.ger.corp.intel.com ([10.252.57.154])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:13:49 -0700
Date:   Wed, 11 Oct 2023 14:13:47 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 06/10] PCI/DPC: Use FIELD_GET()
In-Reply-To: <20231011120739.00005d7d@Huawei.com>
Message-ID: <f6c43aea-8e30-c3df-8318-3e9f79aaf6c@linux.intel.com>
References: <20231010204436.1000644-1-helgaas@kernel.org> <20231010204436.1000644-7-helgaas@kernel.org> <20231011120739.00005d7d@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 11 Oct 2023, Jonathan Cameron wrote:

> On Tue, 10 Oct 2023 15:44:32 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Use FIELD_GET() to remove dependences on the field position, i.e., the
> > shift value.  No functional change intended.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> A question about what 'rules' you are applying for using these macros
> vs choosing not not do so. Personally I prefer using them even for
> flag fields mostly because it makes the code more consistent and
> the compiler should remove any unnecessary shifts that result.
> 
> > ---
> 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index eeec1d6f9023..a9fdc2e3f110 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -6154,7 +6154,7 @@ static void dpc_log_size(struct pci_dev *dev)
> >  	if (!(val & PCI_EXP_DPC_CAP_RP_EXT))
> 
> This is what I'm commenting on below.
> 
> >  		return;
> >  
> > -	if (!((val & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8)) {
> > +	if (FIELD_GET(PCI_EXP_DPC_RP_PIO_LOG_SIZE, val) == 0) {
> 
> Why do this one and not the one just above?
> In both cases extracting a field then comparing it to 0, I'm not sure
> it makes sense to care if that field is 1 bit or multiple bit.

I cannot speak for Bjorn but at least I've left flag checks untouched
(but when pulling the flag into a variable, I've made it with FIELD_GET()).

In anycase, that seems minor issue though compared with defined values of 
the field being incompatible with the FIELD_GET()ed value (when the shift 
is non-zero). I wish there would be good solution to that but so far I've 
not come up anything that would be short and simple enough.

-- 
 i.

