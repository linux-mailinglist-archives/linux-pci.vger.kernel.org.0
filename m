Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2349B79D16A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 14:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235295AbjILMxH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Sep 2023 08:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbjILMxH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2023 08:53:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E78BC4;
        Tue, 12 Sep 2023 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694523183; x=1726059183;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/qKLUiqSeY+lsbMsVjaPVYKIqR7Sz69ai5lJ4YtASLU=;
  b=GsGK8qoyHsfVLxYrWNkdk9ys4KIsXvOOIPCyLtnkWysV0dVsMdgTl9cR
   9Vh57Y1iI/Q2pvGlCH7MsS6HrykC+Hvnx63c5iwcpZrpFwwMGhTieYRK0
   dv9F34sjRGO3cQlWvu+UKfyX4lQZSkbycJPwoKYnh3BM3ogQPcFpLAdEl
   e3HccEvGCvBgu2JBuOqeZedgQalz/SwG4nC1QctE9JFwgiXG+hTZFMcUS
   maAP+hiNrM3Qwi93NZoJmdZOmQQgcxIGgxjxTAucJkOiqxnlnM57NwRPw
   0u6svNzA4mMYDcX+dLfjDLfjrJrte6/ZvzeqlNaPPI+kDqwcUIK6RAOyM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="377278389"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="377278389"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:53:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="778784295"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="778784295"
Received: from npejicx-mobl.ger.corp.intel.com ([10.251.217.90])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 05:52:57 -0700
Date:   Tue, 12 Sep 2023 15:52:54 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 00/10] Add PCIe Bandwidth Controller
In-Reply-To: <f35db90cd67adf4b0f48cd6f2a6ad8fbd0c1a679.camel@linux.intel.com>
Message-ID: <8c5b7c51-12c2-602c-b70-f819ae8610ee@linux.intel.com>
References: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com>  <fa5a20d0-77db-58bd-3956-ac664dffa587@quicinc.com>  <21b95d9-86a5-dcb0-9dda-3f1cdd426b9e@linux.intel.com>  <647e2b5e-6064-dbfa-bb56-f74358efd1fe@quicinc.com>  <25bf206e-864b-644-9b4-a0f461b4285@linux.intel.com>
 <f35db90cd67adf4b0f48cd6f2a6ad8fbd0c1a679.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-160313703-1694523182=:2125"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-160313703-1694523182=:2125
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 11 Sep 2023, srinivas pandruvada wrote:
> On Mon, 2023-09-11 at 18:47 +0300, Ilpo Järvinen wrote:
> > 
> > Okay, thanks for the clarification. So the point is to plan for
> > adding 
> > support for Link Width later and currently only support throttling
> > Link 
> > Speed. In any case, the Link Width control seems to be controlled
> > using 
> > a different approach (Link Width change does not require Link
> > Retraining).
> > 
> > I don't know either how such 2 dimensioned throttling (Link Speed and
> > Link Width) is supposed to be realized using the thermal/cooling
> > device 
> > interface which only provides a single integer as the current state.
> > That 
> > is, whether to provide a single cooling device (with a single integer
> > exposed to userspace) or separate cooling device for each dimension?
> > 
> > Perhaps thermal people could provide some insight on this? Is there
> > some 
> > precedent I could take look at?
>
> Yes. The processor cooling device does similar. 1-3 are reserved for P-
> state and and 4-7 for T-states.
> 
> But I don't suggest using such method. This causes confusion and
> difficult to change. For example if we increase range of P-state
> control, then there is no way to know what is the start point of T-
> states.

Yes. I understand it would be confusing.

> It is best to create to separate cooling devices for BW and link width.

Okay. If that's the case, then I see no reason to add the Link Width 
cooling device now as it could do nothing besides reporting the current 
link width.

The only question that then remains is how to take this into account in 
the naming of the cooling devices, currently PCIe_Port_<pci_name()> is 
used but perhaps it would be better to change that to 
PCIe_Port_Link_Speed_... to allow PCI_Port_Link_Width_... to be added 
later beside it?

> Also there is a requirement that anything you add to thermal sysfs, it
> should have some purpose for thermal control. I hope Link width control
> is targeted to similar use case BW control.

Ability to control Link Width seems to be part of PCIe 6.0 L0p. AFAICT, 
the reasons are to lower/control power consumption so it seems to be 
within scope.


-- 
 i.

--8323329-160313703-1694523182=:2125--
