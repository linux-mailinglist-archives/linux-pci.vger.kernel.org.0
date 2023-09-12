Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B201779D85E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 20:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbjILSIm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Sep 2023 14:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjILSIl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Sep 2023 14:08:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8A1115;
        Tue, 12 Sep 2023 11:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694542118; x=1726078118;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=mprH+mImacg4v8l6F2x/ClD1vyYpU9i+YE6QNB46q8g=;
  b=T3WEemOGFfPeGCdn4XFsjDiO5mF1oxToA0qfD/F579+KeyEeLpH1s7Ky
   IN+zVwyeSGI4KaRv0Fzimo+SyBL6X7cEEQyiMcB6Dgvi9P1LxeXMZH2li
   RXw2kB92mQoQuqRQ6bsBmARk3VW1qKsqpcJkWCfq9brwCr0HSI66TiFsI
   iRo2rvGQdLHKHT9iNTh9aEHe9lqe9iq58Xr2FUeIXpzswl+Gn0yGlu7rt
   5yDe5xeygR4O+SBLEXv738aM10jFTesOCJvShwJwyELFi1ypJ/FrffaRg
   QWtmm2vR47EXC5WeiPB41cnwtDovqQpo3zsWroHdkYotTEr11ePuSNcbS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="368726732"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="368726732"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 11:08:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="813942731"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="813942731"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.66.7])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 11:08:34 -0700
Message-ID: <502357b828dd2dd4aa6b5e29969a78dfd206b262.camel@linux.intel.com>
Subject: Re: [PATCH 00/10] Add PCIe Bandwidth Controller
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Sep 2023 11:08:34 -0700
In-Reply-To: <59c7b5dc2adddf574d0a920e5f7195c418292042.camel@linux.intel.com>
References: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com>
         <fa5a20d0-77db-58bd-3956-ac664dffa587@quicinc.com>
         <21b95d9-86a5-dcb0-9dda-3f1cdd426b9e@linux.intel.com>
         <647e2b5e-6064-dbfa-bb56-f74358efd1fe@quicinc.com>
         <25bf206e-864b-644-9b4-a0f461b4285@linux.intel.com>
         <f35db90cd67adf4b0f48cd6f2a6ad8fbd0c1a679.camel@linux.intel.com>
         <8c5b7c51-12c2-602c-b70-f819ae8610ee@linux.intel.com>
         <59c7b5dc2adddf574d0a920e5f7195c418292042.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2023-09-12 at 10:45 -0700, srinivas pandruvada wrote:
> On Tue, 2023-09-12 at 15:52 +0300, Ilpo J=C3=A4rvinen wrote:
> > On Mon, 11 Sep 2023, srinivas pandruvada wrote:
> > > On Mon, 2023-09-11 at 18:47 +0300, Ilpo J=C3=A4rvinen wrote:
> > >=20
> > >=20
>=20
> [...]
>=20
> > > But I don't suggest using such method. This causes confusion and
> > > difficult to change. For example if we increase range of P-state
> > > control, then there is no way to know what is the start point of
> > > T-
> > > states.
> >=20
> > Yes. I understand it would be confusing.
> >=20
> > > It is best to create to separate cooling devices for BW and link
> > > width.
> >=20
> > Okay. If that's the case, then I see no reason to add the Link
> > Width=20
> > cooling device now as it could do nothing besides reporting the
> > current=20
> > link width.
> >=20
> > The only question that then remains is how to take this into
> > account
> > in=20
> > the naming of the cooling devices, currently PCIe_Port_<pci_name()>
> > is=20
> > used but perhaps it would be better to change that to=20
> > PCIe_Port_Link_Speed_... to allow PCI_Port_Link_Width_... to be
> > added
> > later beside it?
> It is better in that way to add BW=C2=A0
sorry, link width controller

> controller later.
>=20
> Also adding separate cooling device will let thermal configuration,
> choose different method at different thermal thresholds or all
> together.
>=20
> Thanks,
> Srinivas
>=20
> >=20
> > > Also there is a requirement that anything you add to thermal
> > > sysfs,
> > > it
> > > should have some purpose for thermal control. I hope Link width
> > > control
> > > is targeted to similar use case BW control.
> >=20
> > Ability to control Link Width seems to be part of PCIe 6.0 L0p.
> > AFAICT,=20
> > the reasons are to lower/control power consumption so it seems to
> > be=20
> > within scope.
> >=20
> >=20
>=20

