Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC23748F6D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jul 2023 22:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjGEUxN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 16:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjGEUxM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 16:53:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EE71700
        for <linux-pci@vger.kernel.org>; Wed,  5 Jul 2023 13:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688590391; x=1720126391;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=K8JRDyyWHb+JConTm87o+5swguzzjVDv/j4c6KI69AE=;
  b=gL6i1qBPFdbf40R5TC9R1CxIcNleeG68bQZ7mrKS9XvXEukp5IRXn1li
   Q+SDJJVtNIDYgNfzK0MGMKHGnbnonHiFTfA3jJH+mOY3SQmGOP16U9tTU
   NcfdAssk0Q4sm6vWIk4umBnqpaf1HNV+PjFMnrTxeT6qmh1ggrB1raEBY
   8U0BEHhfgA9/jUczHMo/neRndhSaYtM1KsiyBHC4ZXrwwMTzk6dgpxwxS
   2D8BCJ3eUp/P0iUceMQDkq3OTacSmqo8oADoHazYTJYBCmEi8XVKY3KGg
   RWiya2NSyVHpF0mhHAvRDkVWvR2Rdt/lVCiDwk8vyPbOvsoZymri6lqzH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="394193490"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="394193490"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 13:53:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="809388906"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="809388906"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jul 2023 13:53:09 -0700
Received: from [10.54.75.144] (debox1-desk1.jf.intel.com [10.54.75.144])
        by linux.intel.com (Postfix) with ESMTP id 5AC0D580BB8;
        Wed,  5 Jul 2023 13:53:09 -0700 (PDT)
Message-ID: <098da63daae434f6ac0d34ea5303ccd8fb0435c1.camel@linux.intel.com>
Subject: Re: [PATCH] PCI/ASPM: Add back L1 PM Substate save and restore
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Thomas Witt <thomas@witt.link>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
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
Date:   Wed, 05 Jul 2023 13:53:09 -0700
In-Reply-To: <7efaf5d9-9469-9710-8a04-1483bc45c8b6@witt.link>
References: <20230627100447.GC14638@black.fi.intel.com>
         <20230627204124.GA366188@bhelgaas>
         <20230628064637.GF14638@black.fi.intel.com>
         <650f68a1-8d54-a5ad-079b-e8aea64c5130@witt.link>
         <20230628105940.GK14638@black.fi.intel.com>
         <4b47ec58-dc34-1129-4a50-baf2b84b0f53@witt.link>
         <8af8d82dd0dc69851d0cfc41eba6e2acb22d2666.camel@linux.intel.com>
         <20230630104154.GS14638@black.fi.intel.com>
         <7efaf5d9-9469-9710-8a04-1483bc45c8b6@witt.link>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Thomas,

On Fri, 2023-06-30 at 18:58 +0200, Thomas Witt wrote:
> > On 30/06/2023 12:41, Mika Westerberg wrote:
> > > > @Thomas, below is an updated patch. I wonder if you could try it ou=
t?
> > > > This one restores L1 substates first and then L0s/L1 as the spec
> > > > suggests. If this does not work, them I'm not sure what to do becau=
se
> > > > now we should be doing exactly what the spec is saying (unless I
> > > > misinterpret something):
> > > >=20
> > > > =C2=A0=C2=A0 - Write L1 enables on the upstream component first the=
n downstream
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 (this is taken care by the parent child or=
der of the Linux PM).
> > > > =C2=A0=C2=A0 - Program L1 SS before L1 enables
> > > > =C2=A0=C2=A0 - Program L1 SS enables after rest of the fields in th=
e capability
> >=20
> > Sadly, same as before. With s2idle, power consumption stays up, but=20
> > suspend/resume works, with deep it does not correctly suspend the PCI=
=20
> > devices.

Mika is now out on extended vacation. We still need a solution that will en=
able
the L1 substate save/restore without breaking your system. I'd like to try =
to
get the power consumption lowered on your system while suspended with s2idl=
e.
The s0ix self test script will really help to tell us where to start. You c=
an
provide the results in the bugzilla.

The other thing we can do is find out why it only breaks under S3. It could=
 be
timing related, so I've attached another patch to the bugzilla to test this=
.

https://bugzilla.kernel.org/attachment.cgi?id=3D304553

Please let me know if it works. Thanks.

David
