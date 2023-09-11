Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFFD79B6D6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350476AbjIKVit (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242551AbjIKPry (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 11:47:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E46121;
        Mon, 11 Sep 2023 08:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694447270; x=1725983270;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=X08U4r/zjdzoD2xlVs+dRrXtqyQrZjNfvPMLi8zpWCM=;
  b=Zq2JNCIc+9yIqGHnEy76FHTSvESKp2+Skka2V9E3cgWOvKIYc3Ou7mvl
   05D2kVK8KjQ/Jenmr4sQaDJmo8E5pD9XSjUacWDWYIeePZuUpJpNmzpdg
   qfWodjQaBUXLBzut9SD48+7CQX+JL8YFP3SoLq3X7DJqx/kJOoDL4orgt
   GUK3wv7mU4eJLJmsButhTPknq48xz+K86Cah72JdHmxEZZLma+0J3Jc7N
   WtJfJZeuM3mp5LKG+171ToB9hD4zWM8r2hgCAjTgBpO6SnqZ783QqK8Gz
   CbzBRSPuwm2cITFuVo/XHCZtlS5coxDd/WT0+qSt3pPahL0kSlvNhn32c
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378034289"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="378034289"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 08:47:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="772630737"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="772630737"
Received: from mzarkov-mobl3.ger.corp.intel.com ([10.252.36.200])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 08:47:21 -0700
Date:   Mon, 11 Sep 2023 18:47:19 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 00/10] Add PCIe Bandwidth Controller
In-Reply-To: <647e2b5e-6064-dbfa-bb56-f74358efd1fe@quicinc.com>
Message-ID: <25bf206e-864b-644-9b4-a0f461b4285@linux.intel.com>
References: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com> <fa5a20d0-77db-58bd-3956-ac664dffa587@quicinc.com> <21b95d9-86a5-dcb0-9dda-3f1cdd426b9e@linux.intel.com> <647e2b5e-6064-dbfa-bb56-f74358efd1fe@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-2146389531-1694445120=:1823"
Content-ID: <d4d8e4d9-df60-ff9e-806d-24cbd22967d6@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2146389531-1694445120=:1823
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <c9761ce4-b9a2-dcba-a6f7-24d03a34d4@linux.intel.com>

+ thermal people.

On Mon, 11 Sep 2023, Krishna Chaitanya Chundru wrote:
> On 9/4/2023 4:46 PM, Ilpo Järvinen wrote:
> > On Mon, 4 Sep 2023, Krishna Chaitanya Chundru wrote:
> > > On 8/17/2023 5:46 PM, Ilpo Järvinen wrote:
> > > > 
> > > > This series adds PCIe bandwidth controller (bwctrl) and associated PCIe
> > > > cooling driver to the thermal core side for limiting PCIe link speed
> > > > due to thermal reasons. PCIe bandwidth controller is a PCI express bus
> > > > port service driver. A cooling device is created for each port the
> > > > service driver finds if they support changing speeds.
> > > I see we had support for only link speed changes here but we need to add
> > > support for
> > > 
> > > link width change also as bandwidth notification from PCIe supports both
> > > link
> > > speed and link width.
> > Hi,
> > 
> > Thanks for the comment. In case you mean that the changes in Link Width
> > should be reported correctly, they already are since the sysfs interface
> > reads them directly from LNKSTA register.
> > 
> > Or did you perhaps mean that Bandwidth Controller should support also
> > changing Link Width? If this is the case I don't know how it can be
> > realized so a pointer on how it can be achieved would be appreciated.
> 
> I didn't have any idea on how thermal framework works.
> 
> But as we are adding bandwidth controller support we need to add support for
> width change also, may be we are not using this now, but we may need it in the
> future.
> 
> We had similar use case based on the bandwidth requirement on devices like
> WLAN, the client try to reduce or increase the link speed and link width.
> 
> So in the bandwidth controller driver we can add support for link width also.
> So any client can easily use the driver to change link speed or width or both
> to reduce the power consumption.
> 
> Adding link width support should be similar to how you added the link speed
> supported.
> 
> Please correct me if I misunderstood something here.

Hi,

Okay, thanks for the clarification. So the point is to plan for adding 
support for Link Width later and currently only support throttling Link 
Speed. In any case, the Link Width control seems to be controlled using 
a different approach (Link Width change does not require Link Retraining).

I don't know either how such 2 dimensioned throttling (Link Speed and 
Link Width) is supposed to be realized using the thermal/cooling device 
interface which only provides a single integer as the current state. That 
is, whether to provide a single cooling device (with a single integer 
exposed to userspace) or separate cooling device for each dimension?

Perhaps thermal people could provide some insight on this? Is there some 
precedent I could take look at?

-- 
 i.
--8323329-2146389531-1694445120=:1823--
