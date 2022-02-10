Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFB24B0CCC
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 12:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbiBJLws (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 06:52:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237520AbiBJLwr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 06:52:47 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD6BFED;
        Thu, 10 Feb 2022 03:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644493969; x=1676029969;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B1OGRtVIjoiNg+W45MWSmaIT1YHoKiv18s/urFP4N4Q=;
  b=lY1r0NfZzUHYS+z+T1xLTuXXXGXCKYAxPEtJJ03+dpkg+++7G+hks6Fg
   fECddcBN+GmOy05oF213beQ/UQshAC8VrQv64DPUe12WCvV/fWmITsXDC
   uUEL04p2t0E1bOHQf/sUpk5zcJYRf4RWymUCIfjhzJkyB6sDzB7k4r8WE
   X399ELD/0zMykzh6C2vdckM+dSG0bki5dPzsvQcH2ZdbZJ7V6Gw2/TaPw
   Z4F9psr4JRlCdWdIeHf9ohPOTgySFP0AhzXOWJgxJ/uo1osruD/tUq7/l
   vGRroecTS/jhNzQKGPqzGhxMWhUCXV0KLcUH3+V8REw8jXnAonEAeTNwk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="335889656"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="335889656"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 03:52:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="541575532"
Received: from mtkaczyk-mobl1.ger.corp.intel.com (HELO localhost) ([10.213.17.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 03:52:06 -0800
Date:   Thu, 10 Feb 2022 12:52:01 +0100
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <kbusch@kernel.org>, kw@linux.com,
        helgaas@kernel.org, lukas@wunner.de, pavel@ucw.cz,
        linux-cxl@vger.kernel.org, martin.petersen@oracle.com,
        James.Bottomley@hansenpartnership.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH v2 0/3] Add PCIe enclosure management support
Message-ID: <20220210125201.00003976@linux.intel.com>
In-Reply-To: <cover.1643822289.git.stuart.w.hayes@gmail.com>
References: <cover.1643822289.git.stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed,  2 Feb 2022 11:59:10 -0600
Stuart Hayes <stuart.w.hayes@gmail.com> wrote:

> (3) Modifies the nvme driver to create an auxiliary device to which
> the pcie_em driver can attach.
> 
> These patches do not modify the cxl or pcieport drivers to add
> support, though the driver was designed to make it easy to do so.

Hi Stuart,

I would like to help you with NPEM testing. Currently I have setup with
NPEM enabled in Downstream port. It will require to add support for
pcieport. Could you add it in next version?

I'm also searching for a drive with NPEM to do full validation (when
both Downstream and the SSD are reporting capability). If you can point
me the model, it will be helpful.

Thanks,
Mariusz
