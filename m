Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4018785182
	for <lists+linux-pci@lfdr.de>; Wed, 23 Aug 2023 09:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjHWH3R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 03:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjHWH3R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 03:29:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00AB128;
        Wed, 23 Aug 2023 00:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692775727; x=1724311727;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SUoqDDcxYlG8V3jukvYQZ2xipB4tsoc0+yDmyBxqiMc=;
  b=EF/VMSmIx0VZgKKtcrxlgMDmCJoOCjaiAEX/LSMxjQFpls7Klf69zs2j
   VrFw/LF9MW3xOD5TrdHBiiJiWhWp3crTOrfTKd7hi46ZbVRMrSgDgMzH2
   IfG7vBmPQMfzYk9F7Er3mVzUerMkLH/KgErcuyd0CI7v0fz3DQoezEO1t
   EkXmfXkzi+9H/TzVturICwn7U26goFNasK96xmpQYU7d56Z/WbOUaM9un
   lY2aP5motjaPLesssJhn82B8CObtHiS2UTsqGH0SCPvFgStuWegvyCzBs
   QQiKvAqLxhHDfsqq8tJOCU0+bgQsPFi1ibxhN2i5/aKke8GglzwdgbQVo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="376822384"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="376822384"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 00:28:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="686336420"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="686336420"
Received: from amangalo-mobl4.ger.corp.intel.com ([10.252.55.236])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 00:28:39 -0700
Date:   Wed, 23 Aug 2023 10:28:36 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Feiyang Chen <chenfeiyang@loongson.cn>
cc:     bhelgaas@google.com, rafael.j.wysocki@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        helgaas@kernel.org, anders.roxell@linaro.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        guyinggang@loongson.cn, siyanteng@loongson.cn,
        chenhuacai@loongson.cn, loongson-kernel@lists.loongnix.cn,
        chris.chenfeiyang@gmail.com
Subject: Re: [PATCH v2] PCI/PM: Only read PCI_PM_CTRL register when
 available
In-Reply-To: <CAJZ5v0hpngg6WF7Q2P-MhcTGN8qtAx2U2-ODm=YMzs9=C44DSQ@mail.gmail.com>
Message-ID: <68a839ff-817e-c5b6-c0a9-7862792786c2@linux.intel.com>
References: <20230822115514.999111-1-chenfeiyang@loongson.cn> <c8beef70-1639-c11e-ae38-d8a07279720@linux.intel.com> <CAJZ5v0hpngg6WF7Q2P-MhcTGN8qtAx2U2-ODm=YMzs9=C44DSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1547078131-1692775722=:1805"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1547078131-1692775722=:1805
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 22 Aug 2023, Rafael J. Wysocki wrote:

> On Tue, Aug 22, 2023 at 3:24 PM Ilpo Järvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> >
> > On Tue, 22 Aug 2023, Feiyang Chen wrote:
> >
> > > When the current state is already PCI_D0, pci_power_up() will return
> > > 0 even though dev->pm_cap is not set. In that case, we should not
> > > read the PCI_PM_CTRL register in pci_set_full_power_state().
> >
> > IMHO, this is a bit misleading because after this patch, pci_power_up()
> > returns always an error if dev->pm_cap is not set.
> 
> Yes, it does, but it has 2 callers only and the other one ignores the
> return value, so this only matters here.

I did only mean that the changelog could be more clear how it achieves 
the desired result (as currently it states opposite of what the code 
does w.r.t. that return value).

I'm not against the approach taken by patch.

-- 
 i.

--8323329-1547078131-1692775722=:1805--
