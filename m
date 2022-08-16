Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E393595A48
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 13:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiHPLeZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 07:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbiHPLd4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 07:33:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECC532DBD;
        Tue, 16 Aug 2022 03:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660647348; x=1692183348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z9fMHT2HnWmkrrf6jkOtAdYck/68fWD7Cuc65/D83ew=;
  b=c4wQZ93WzwWOfm40IRBtnZiNgIkIMvGBR+Y9B5176/AEZj6FBGdAJZrm
   QgGE6NeR+9E/H/bVZVsYdZ+k9fNaor6Feu7JH73H+iDFi/qUPvKz6oq0h
   aqu9N0cw1t0eSnX1BGOBV1vwUErvSvc6TvkYObAO/oUpJ4098NcJe4QEg
   QAkXICJjoVcc1p7mJRdKSG133TtHRAylq3jATCAWsOZ5Uq21iblDnWeSW
   JzTCGngnhRoCImW7octHSO76LGGuCpBX5tuG/JCS3GJT9oytH8EkX5m2N
   uG/WlwxKvEncSkplWERZPIDs01jc1RNuchUE5FdpSVFiGDuguC/+VmWX6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="290939780"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="290939780"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 03:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="733250064"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 16 Aug 2022 03:55:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id A35AA2F6; Tue, 16 Aug 2022 13:55:55 +0300 (EEST)
Date:   Tue, 16 Aug 2022 13:55:55 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, koba.ko@canonical.com,
        "David E . Box" <david.e.box@linux.intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Disable upstream port PTM during suspend
Message-ID: <Yvt3u2zQnYrOEbV+@black.fi.intel.com>
References: <20220706123244.18056-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706123244.18056-1-kai.heng.feng@canonical.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 06, 2022 at 08:32:44PM +0800, Kai-Heng Feng wrote:
> On Intel Alder Lake platforms, Thunderbolt entering D3cold can cause
> some errors reported by AER:
> pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: 0000:00:1d.0
> pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
> pcieport 0000:00:1d.0:   device [8086:7ab0] error status/mask=00100000/00004000
> pcieport 0000:00:1d.0:    [20] UnsupReq               (First)
> pcieport 0000:00:1d.0: AER:   TLP Header: 34000000 08000052 00000000 00000000
> thunderbolt 0000:0a:00.0: AER: can't recover (no error_detected callback)
> xhci_hcd 0000:3e:00.0: AER: can't recover (no error_detected callback)
> pcieport 0000:00:1d.0: AER: device recovery failed
> 
> In addition to that, it can also block system from suspending when
> a Thunderbolt dock is attached to the same system.
> 
> The original approach [1] is to disable AER and DPC when link is in
> L2/L3 Ready, L2 and L3, but Bjorn identified the root cause is the Unsupported
> Request:
>   - 08:00.0 sent a PTM Request Message (a Posted Request)
>   - 00:1d.0 received the PTM Request Message
>   - The link transitioned to DL_Down
>   - Per sec 2.9.1, 00:1d.0 discarded the Request and reported an
>     Unsupported Request
>   - Or, per sec 6.21.3, if 00:1d.0 received a PTM Request when its
>     own PTM Enable was clear, it would also be treated as an
>     Unsupported Request
> 
> And further: 'David did something like this [1], but just for Root Ports. That
> looks wrong to me because sec 6.21.3 says we should not have PTM enabled in an
> Upstream Port (i.e., in a downstream device like 08:00.0) unless it is already
> enabled in the Downstream Port (i.e., in the Root Port 00:1d.0).'
> 
> So also disable upstream port PTM to make the PCI driver conform to the spec
> and solve the issue.
> 
> [1] https://lore.kernel.org/all/20220408153159.106741-1-kai.heng.feng@canonical.com/
> [2] https://lore.kernel.org/all/20220422222433.GA1464120@bhelgaas/
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215453
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=216210
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: David E. Box <david.e.box@linux.intel.com>
> Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
