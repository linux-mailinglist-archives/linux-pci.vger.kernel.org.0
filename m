Return-Path: <linux-pci+bounces-857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E012810E8E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 11:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB97F1F210C0
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 10:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2C22209F;
	Wed, 13 Dec 2023 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="pOIzASqW";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="ou3h3gYQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC5AE8
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 02:35:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 3147EC0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702463757; bh=IaJKXGzvPcaP+dnaaQxUZW1vBXF08tF20iI7r6+4Fb8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=pOIzASqWxJsq7zU5SiCtY8SATs2y9F306RNi7HQtBXzicyxrufM7qQjjusP45VDaQ
	 C7GuZPBDf2htRjGGfxJKfOH8G7CX4cbUYsPQ2vETJRmgxnIxKVozcwDP6qpwEjD2UV
	 Pql1RgG8/UnWO0j/mDWHw8bn7jyC35EGLXZPskR+Oy2FM98MtlK0XmWKRUSujsisne
	 yXgQveBlDMngaxMzHJfZkIAKv8vQhpy1dCop9j0C0WpxCI+vJeF5TqpRW6IftXXxg2
	 X95v5/fQLkyJktTYFdvYrOT4kRtHNytuMBBKS4NditqhrflR1hcbRfKtAvtXrcmXjL
	 Bm6G1wDvNCySQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702463757; bh=IaJKXGzvPcaP+dnaaQxUZW1vBXF08tF20iI7r6+4Fb8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=ou3h3gYQlNPkz5MQgmritwL9RcL9BiIUq9mvhM/ENAobLZo9HrpGjiuXwobQZjyFl
	 lu8P10+ovZ+FBI2P+LgzZMtGYw75ftgirH26cRwrhIS4EpVvaqdYIRwSQflPMUZID1
	 f7WGyVCnQ6u8g1iS8gLu/Ks5huMrVRotq965bdIpEbECs/68S6NAVDY93gIGi6T95X
	 0j4arBBGZFAN70DUwdNiv84xjICU4kK5B+gu8WU1amhYN6ngKuaPovpdb+txJtG1YA
	 wj7cY5mtP2OswKuP0aOQbJcqCLgXKVjLJ3jzp25r2Qvnqls7apdy6NxZXYrIVq8iP4
	 gXOh1FXTS8l3Q==
Date: Wed, 13 Dec 2023 13:35:54 +0300
From: Nikita Proshkin <n.proshkin@yadro.com>
To: Martin =?UTF-8?B?TWFyZcWh?= <mj@ucw.cz>
CC: <linux-pci@vger.kernel.org>, <linux@yadro.com>, Sergei Miroshnichenko
	<s.miroshnichenko@yadro.com>, Nikita Proshkin <n.proshkin@yadro.com>
Subject: Re: [PATCH 05/15] pciutils-pcilmr: Add margining process functions
Message-ID: <20231213133554.6c78dd3f.n.proshkin@yadro.com>
In-Reply-To: <mj+md-20231208.173154.29528.nikam@ucw.cz>
References: <20231208091734.12225-1-n.proshkin@yadro.com>
	<20231208091734.12225-6-n.proshkin@yadro.com>
	<mj+md-20231208.173154.29528.nikam@ucw.cz>
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

On Fri, 8 Dec 2023 18:35:58 +0100
Martin Mare=C5=A1 <mj@ucw.cz> wrote:

> > +union margin_payload {
> > +  unsigned int payload : 8;
> > +
> > +  struct caps {
> > +    bool volt_support : 1;
> > +    bool ind_up_down_volt : 1;
> > +    bool ind_left_right_tim : 1;
> > +    bool sample_report_method : 1;
> > +    bool ind_error_sampler : 1;
> > +  } caps;
> > +
> > +  unsigned int timing_steps : 6;
> > +  unsigned int voltage_steps : 7;
> > +  unsigned int offset : 7;
> > +  unsigned int max_lanes : 5;
> > +  unsigned int sample_rate : 6;
> > +
> > +  struct step_resp {
> > +    unsigned int err_count : 6;
> > +    unsigned int status : 2;
> > +  } step_resp;
> > +
> > +  struct step_tim {
> > +    unsigned int steps : 6;
> > +    bool go_left : 1;
> > +  } step_tim;
> > +
> > +  struct step_volt {
> > +    unsigned int steps : 7;
> > +    bool go_down : 1;
> > +  } step_volt;
> > +
> > +} __attribute__((packed));
>=20
> Please do not assume that every compiler used to compile the pciutils sup=
ports
> GCC extensions. See lib/sysdep.h for how we handle such things.
>=20
> Also, I am not sure that bit fields are good idea: they save a little data
> space, but they expand code.

I had an idea to use anonymous structures here, which would make field
accesses shorter. And actually I would prefer to use bit fields instead of
manipulating bits. But looks like it will be hard to implement this
approach without using GCC packed feature and make it portable.
It seems that I will have to implement the option with a pack of macro=20
wrappers around bit masks.

Best regards,
Nikita Proshkin

