Return-Path: <linux-pci+bounces-858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0075C810EA5
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 11:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3279F1C20342
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 10:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AA61EB35;
	Wed, 13 Dec 2023 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="eJI9Pw58";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="RzJLZ/R8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8360CD5
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 02:41:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com E3840C0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702464059; bh=5Me5RdfPT0pos2U1EBffNT7RRG4UEn8Wy7uGz/i3h1Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=eJI9Pw58eWOvi7r8/Hh57+7mk3+l1jeCqOqWt0F9MFbv7KzA2YZk3jc8FPgGKj7na
	 s8X1+shAiADj50vER5VDrW5lQey1Y+GXvywnySx8ReRSlmA1Pwol5f0W5KwHdBiDrr
	 6riHBDLEeMIoWDp/hHSGVBTe/a046RQv5KIoS/BxOzDPl5RwpJnjA/MxanBi4sgtbM
	 nlc7x+pBpUmxAWQZ4wgawY+Xw4VdOax2bAJohZFeHCay3nq7P5Fg5BrXuTEDhVdBI2
	 pcVy9gsqaUfeMDpYvj5ApynQxjb8g4yKbSzN7LC3eY5TOAa1zSia8azxEO0BvoOR0U
	 smeQ5auD32rZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702464059; bh=5Me5RdfPT0pos2U1EBffNT7RRG4UEn8Wy7uGz/i3h1Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=RzJLZ/R8yeTmV+d5lKou4OcZBumLLQs67nlit4tasag/4Z8IStHIXRVwpMAUmjBxn
	 U75zeCQfsFbf0Y6LeYXRcfCG8QcJfV91L625DSqj73FmU6xDCHEiquLBzEg58G0zAI
	 zIwecnn4hzFoEO64siBO+YYalPDO5AIwxAHzUCf4EGkT5/ZJ/57F9N7BR+MBFo45sb
	 jmUD/+KLAMTH/Sx+stkC5IlHmU8v7NkdbDQi27G3Ms5SBit27zloEe0xn9tZQ1eC7l
	 4ZQJR81i/n3PKL/qOMjdfjvYZtAa5Ctx814h5HLAgT9Lt6TbEBYr0qs++q69pq2yuQ
	 NLvRDmFJt5tpQ==
Date: Wed, 13 Dec 2023 13:40:56 +0300
From: Nikita Proshkin <n.proshkin@yadro.com>
To: Martin =?UTF-8?B?TWFyZcWh?= <mj@ucw.cz>
CC: <linux-pci@vger.kernel.org>, <linux@yadro.com>, Sergei Miroshnichenko
	<s.miroshnichenko@yadro.com>, Nikita Proshkin <n.proshkin@yadro.com>
Subject: Re: [PATCH 10/15] pciutils-pcilmr: Add support for unique hardware
 quirks
Message-ID: <20231213134056.28b7e82e.n.proshkin@yadro.com>
In-Reply-To: <mj+md-20231208.173733.30953.nikam@ucw.cz>
References: <20231208091734.12225-1-n.proshkin@yadro.com>
	<20231208091734.12225-11-n.proshkin@yadro.com>
	<mj+md-20231208.173733.30953.nikam@ucw.cz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)

On Fri, 8 Dec 2023 18:38:20 +0100
Martin Mare=C5=A1 <mj@ucw.cz> wrote:

> > +static bool read_cpuinfo(union cpuinfo *cpuinfo)
> > +{
> > +  FILE *cpu_file =3D fopen("/proc/cpuinfo", "r");
> > +  if (!cpu_file)
> > +    return false;
>=20
> This works only on Linux.
>=20
> Wouldn't it be possible to identify Ice Lake by PCI ID of the root bridge
> instead?

Thanks, great idea! This should work.

Best regards,
Nikita Proshkin

