Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCF0778441
	for <lists+linux-pci@lfdr.de>; Fri, 11 Aug 2023 01:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbjHJXo3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 19:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjHJXo0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 19:44:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F47271E
        for <linux-pci@vger.kernel.org>; Thu, 10 Aug 2023 16:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691711066; x=1723247066;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=y3f7nrdX0hmeLL/nEGz7uK5kKC3xWQsaLnAPxlrO9Ks=;
  b=jTiMPI51LfmJ81aZRWckV2d1H/3gHj3rb/yBciBgayxFs1GnDhmEPmNz
   0Bdip0vTainGFt0b+dFLNq4gIWCEa7DtXNYU7P0LKV5TZwmUGt5bXRS50
   DBV7pqj7rN6BqvdnDZq+wOByDb6+u5Su09Ldm6xP1p6MT11Kov5UZuFIi
   Xf61XO0zwZw2jVM4SC+FZOVN1/3YYUqJ3rHUA71HKfr0/rvdwWktqn8nF
   /pyr4A+J8Mk2Ov7KGh8ZKgUHyZfDJfrkkbJsokiC84TiC2nuLSeqv5dNX
   0+sKL8WPqsp9R48EyIFXyuPMNmkzc/FmAKf+4wIpe5utZyltiqeA2Jnqq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="435445251"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="435445251"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 16:44:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="1063105553"
X-IronPort-AV: E=Sophos;i="6.01,163,1684825200"; 
   d="scan'208";a="1063105553"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 10 Aug 2023 16:44:25 -0700
Received: from tphi-mobl.amr.corp.intel.com (tphi-mobl.amr.corp.intel.com [10.209.57.169])
        by linux.intel.com (Postfix) with ESMTP id 1ED53580D37;
        Thu, 10 Aug 2023 16:44:25 -0700 (PDT)
Message-ID: <64ec2f34620a2b502f2e096fdf7a9f43d742bb7b.camel@linux.intel.com>
Subject: Re: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Thomas Witt <thomas@witt.link>
Cc:     Thomas Witt <kernel@witt.link>, Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Koba Ko <koba.ko@canonical.com>, linux-pci@vger.kernel.org
Date:   Thu, 10 Aug 2023 16:44:24 -0700
In-Reply-To: <20230807075832.GD14638@black.fi.intel.com>
References: <650f68a1-8d54-a5ad-079b-e8aea64c5130@witt.link>
         <20230628105940.GK14638@black.fi.intel.com>
         <4b47ec58-dc34-1129-4a50-baf2b84b0f53@witt.link>
         <8af8d82dd0dc69851d0cfc41eba6e2acb22d2666.camel@linux.intel.com>
         <20230630104154.GS14638@black.fi.intel.com>
         <7efaf5d9-9469-9710-8a04-1483bc45c8b6@witt.link>
         <098da63daae434f6ac0d34ea5303ccd8fb0435c1.camel@linux.intel.com>
         <6673c6a1-16ba-aaa4-707a-70d92d9751f6@witt.link>
         <20230731150128.GK14638@black.fi.intel.com>
         <5d5dc59d-0ce0-c98c-c6c8-f1d748a8d968@witt.link>
         <20230807075832.GD14638@black.fi.intel.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2023-08-07 at 10:58 +0300, Mika Westerberg wrote:
> Hi Thomas,
>=20
> On Sat, Aug 05, 2023 at 09:57:47AM +0200, Thomas Witt wrote:
> > On 31/07/2023 17:01, Mika Westerberg wrote:
> > > Hi Thomas,
> > >=20
> > > Thanks for trying that. Did you manage to try out the S0ix script Dav=
id
> > > suggested? That should show us hopefully what is draining the battery=
 in
> > > s2idle.
> >=20
> > Hi Mika,
> >=20
> > I did, with -s it gives
> >=20
> > Your system does not support low power S0 idle capability.
> > Isolation suggestion:
> > Please check BIOS low power S0 idle capability setting.
> >=20
> > with -r on
> >=20
> > Your system did not achieve the runtime PC10 state during screen ON
>=20
> Thanks for trying. Did you change the "mem_sleep" back to "s2idle"
> before you run the script?

The script checks the FADT to determine if the system supports S0ix and it =
found
that it didn't which is weird since Thomas is setting "mem_sleep" to "deep"=
 from
the default "s2idle" which is based on this bit.

Here are the commands to check it.

  sudo acpidump -n FADT -b
  iasl -d facp.dat
  grep "Low Power S0 Idle" facp.dsl

Thomas, can you confirm what the value of mem_sleep is when you boot and ru=
n the
above to confirm what your hardware supports?

>=20
> > additionally, it encounters a syntax error:
> > ./s0ix-selftest-tool.sh: line 1182: wc:: syntax error in expression (er=
ror
> > token is ":")
>=20
> @David, do you know what might be the issue?

Yes. The latest kernel changes the output of the ltr_show command by adding=
 a
PMC number prefix (since Meteor Lake has more than one PMC now). The script=
 is
erring on the unexpected colon. We'll get this fixed.

David

>=20
> > with -r off, it tries xset which fails due to a lack of xserver.
>=20
> You do have graphics running right? I mean i915 driver is enabled and
> all the firmwares are in place (should come with the distro). I'm asking
> because s2idle typically requires that graphics and pretty much all the
> devices on the SoC have a driver and the accompanying firmwares, and
> that they enter D3 properly.

