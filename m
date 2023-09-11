Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863F379B45A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350674AbjIKVkh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242740AbjIKQON (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 12:14:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178271B8;
        Mon, 11 Sep 2023 09:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694448849; x=1725984849;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=PCK5N7MTX0TyDy4xAO7NmL2IUmc1Gi2m4JoFRYk5vSI=;
  b=F7/AegDloF8uqJB+DF15yRougZ6Mf6QwoxwcraAk8E8OnviuTyEzdyyJ
   wctg9KpZNpTIIuNt9VM3+BbHsSmxh81Z3qbwBNrSm7zf24LXM/4XK+W2u
   ge2JFW1+OY9MWic0KTazlZBYQsy5yqvun7EWeZ4QjBe0jkgX3lk0JFgxr
   k8CeBZrJGa53MY2fAda6s/JnIQnFBd7XIWjri1e9rSSeYiFmt3ASkvj+v
   Zgmir4+9nUejsMtR6HdLjIsLK3pHeFdRVT0I3ISD2pTwfCjaa9h2k/FBj
   QL+jYQ/IAmljfE/7efPIRTEPxhSN62dbbWI9Y0gj2vhWRR8MccX1K1K8z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="409093577"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="409093577"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 09:14:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="858397637"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="858397637"
Received: from spandruv-desk1.amr.corp.intel.com ([10.255.229.210])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 09:14:07 -0700
Message-ID: <f35db90cd67adf4b0f48cd6f2a6ad8fbd0c1a679.camel@linux.intel.com>
Subject: Re: [PATCH 00/10] Add PCIe Bandwidth Controller
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 11 Sep 2023 09:14:07 -0700
In-Reply-To: <25bf206e-864b-644-9b4-a0f461b4285@linux.intel.com>
References: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com>
         <fa5a20d0-77db-58bd-3956-ac664dffa587@quicinc.com>
         <21b95d9-86a5-dcb0-9dda-3f1cdd426b9e@linux.intel.com>
         <647e2b5e-6064-dbfa-bb56-f74358efd1fe@quicinc.com>
         <25bf206e-864b-644-9b4-a0f461b4285@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2023-09-11 at 18:47 +0300, Ilpo J=C3=A4rvinen wrote:
> + thermal people.
>=20
>=20

...

> Hi,
>=20
> Okay, thanks for the clarification. So the point is to plan for
> adding=20
> support for Link Width later and currently only support throttling
> Link=20
> Speed. In any case, the Link Width control seems to be controlled
> using=20
> a different approach (Link Width change does not require Link
> Retraining).
>=20
> I don't know either how such 2 dimensioned throttling (Link Speed and
> Link Width) is supposed to be realized using the thermal/cooling
> device=20
> interface which only provides a single integer as the current state.
> That=20
> is, whether to provide a single cooling device (with a single integer
> exposed to userspace) or separate cooling device for each dimension?
>=20
> Perhaps thermal people could provide some insight on this? Is there
> some=20
> precedent I could take look at?
Yes. The processor cooling device does similar. 1-3 are reserved for P-
state and and 4-7 for T-states.

But I don't suggest using such method. This causes confusion and
difficult to change. For example if we increase range of P-state
control, then there is no way to know what is the start point of T-
states.

It is best to create to separate cooling devices for BW and link width.

Also there is a requirement that anything you add to thermal sysfs, it
should have some purpose for thermal control. I hope Link width control
is targeted to similar use case BW control.

Thanks,
Srinivas


>=20

