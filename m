Return-Path: <linux-pci+bounces-875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4ADA81124A
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 14:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A617281203
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 13:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E3929D11;
	Wed, 13 Dec 2023 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="N+gm+L0y";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="nzGBlvr3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1604EB3
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 05:01:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 30749C000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702472494; bh=aRc/7qzNwKs//OiJWi8vzCgxwN5mKX7bQSdYZwzV//I=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=N+gm+L0ysjxcAWj4i1F9bjfIqw1hmtqTf2eXrIqkOMLKWLdANXioe0SOcFAXfoF8p
	 PpEukqMIH1qhQOSXvxVzjAwlJio6/f8IE9cT2JbW148W6juiW0hjrwIBGZF9SDlvNk
	 DwkvLpDHMsBSm6PMMMmYonZr1L9HXLDWN6n5A5sExSuODVS6Ymh2HKhpA23XeTdJ+i
	 2dG0BIam6I9UHGXusE/jQ72wta9g/PE42UaZM1vEURfWSPdUuyaI4SLLpEI4g8F8K9
	 F9HKIeQ57pajaLSHXugUaM9leFJFOsqzWjKeR+mHoE6HveLdrAcEjZ1rTxaQ75QZzW
	 9Ud3dvSAmhfjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702472494; bh=aRc/7qzNwKs//OiJWi8vzCgxwN5mKX7bQSdYZwzV//I=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=nzGBlvr3CT8n4lWQeIkXD3lqY6MiKOF+THrX/oaZ1+korFxIZCSdylYx97+8bUi+P
	 NvvuhMJwXMkTNkFf7SF6bzErLX0Vuiz+ebNvlzDtQrPmbYm2wSEujqqmIQmcVQGtU5
	 b2L/2LcS/sWuU84d+ajY6qbnRG+2onlcIF+hLQbqi6KcAB6Iw0WYYh9i8RkJk4bSCh
	 6evAYbS5jwXPyiOq1GJNxMNc77zumqEdets6ygiQg08usopDWRImiUxN1M8TjLtU0Q
	 XiUnjzQtbz3X+sn/Kvzhpm+XUg7QMMYvo4jL7xlb3+OwEjvwG+AG959NKgW6jR3VVm
	 V08hidNXZcKTg==
Date: Wed, 13 Dec 2023 16:01:31 +0300
From: Nikita Proshkin <n.proshkin@yadro.com>
To: Martin =?UTF-8?B?TWFyZcWh?= <mj@ucw.cz>
CC: <linux-pci@vger.kernel.org>, <linux@yadro.com>, Sergei Miroshnichenko
	<s.miroshnichenko@yadro.com>, Nikita Proshkin <n.proshkin@yadro.com>
Subject: Re: [PATCH 13/15] pciutils-pcilmr: Add option to save margining
 results in csv form
Message-ID: <20231213160131.330feb9d.n.proshkin@yadro.com>
In-Reply-To: <mj+md-20231213.112217.6063.nikam@ucw.cz>
References: <20231208091734.12225-1-n.proshkin@yadro.com>
	<20231208091734.12225-14-n.proshkin@yadro.com>
	<mj+md-20231208.174204.32403.nikam@ucw.cz>
	<20231213135256.145556b6.n.proshkin@yadro.com>
	<mj+md-20231213.112217.6063.nikam@ucw.cz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)

On Wed, 13 Dec 2023 12:22:45 +0100
Martin Mare=C5=A1 <mj@ucw.cz> wrote:

> > I think that die() from common.c is not suitable here, as the utility a=
t that
> > moment in the code still can and must free up resources malloc'ed in th=
e main
> > function.
>=20
> I don't understand why this is needed -- once the process exits, all memo=
ry
> allocated by it is freed by the kernel.

Well, yes, I suppose in case of most modern operating systems you are right.

This particular function, about which this thread is about, was conceived as
an optional method to save the results of the utility to a file. According =
to
the logic of the utility, by this point the testing process has already been
successfully completed and it seemed to me that the utility should no longer
panic.

On the other hand, it makes sense to return a non-zero code to the user if
something went wrong. In fact, there are a few more cases in the main funct=
ion
of the utility when some checks fail and the utility may exit. If we are
satisfied with the option when the utility does not clean up gracefully,
I can use die() in such cases.

Best regards,
Nikita Proshkin

