Return-Path: <linux-pci+bounces-867-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A41810EFA
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 11:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BADB1C208C8
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 10:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C536022EE4;
	Wed, 13 Dec 2023 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="XF10T0WQ";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="TJ3WGAhV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B910093
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 02:52:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 0BB30C0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702464778; bh=0ANX21fvWXKVlojafEh9VSyHH1AYJA3xOreFehil6Q4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=XF10T0WQVXiltqsQAYwP2a1Wbc8kFxlXr6xynDwEglzbkO6gP43JkCDOFdoEak5ck
	 qZ45z9mKQUBthcq62YNOrXMhOUNcq4qCLYHdtCjyvSKG2WjFbMRotn2upD+ZUXUvjY
	 WT5YAJiv8M+bh0iOsSlA6Gp9KoECNfemLnJTvTsGymcbbgbnnl2lD3cTo7WXnWNQjS
	 Mi5PZM5IpMzWOxEhqHvXDygRSQGyEAnL2AFu2+HV1q0261gJ/Rq4QBhyY+8/y+UEih
	 Mt7ED6qXg2OjiRQnw6kbM2I2nWSs6MLOlrXP4yLYkwWlS1LIhmvuw+SFRBN0qJog0V
	 5PPXtHnBIIOGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702464778; bh=0ANX21fvWXKVlojafEh9VSyHH1AYJA3xOreFehil6Q4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
	b=TJ3WGAhVaz3Y9/CGCgOiioTgAZvNw5gT3ZWqgjypjOkh0EgKcBhXlfoKfPQ12bLbW
	 n21IYkwaJK730s9J+czpDcw/DUIM2Q5KGh5I1Y6HybEyOcc6mtpdT00PCY1L5OZjtz
	 Bx8bj0UYX4M4Y7z8DrQOgZcBj4qZm6dJ0ZFq+kKwU8BOnWAtVlbwz3eBS6KipLW28M
	 fiYtZoELV3hY+KZ6ug+pl0R4cEfrdhu/AaaAhZG2+NObpfnZTIrT+kvc7Zu1CSbvUR
	 GuwLtNua4nIeNTxTuPaT88qZ7F4oDu0+8MX7N5qJhRd5KEjwEJZnhrB840XaMm9tor
	 7OAfLf8IE+Jpg==
Date: Wed, 13 Dec 2023 13:52:56 +0300
From: Nikita Proshkin <n.proshkin@yadro.com>
To: Martin =?UTF-8?B?TWFyZcWh?= <mj@ucw.cz>
CC: <linux-pci@vger.kernel.org>, <linux@yadro.com>, Sergei Miroshnichenko
	<s.miroshnichenko@yadro.com>, Nikita Proshkin <n.proshkin@yadro.com>
Subject: Re: [PATCH 13/15] pciutils-pcilmr: Add option to save margining
 results in csv form
Message-ID: <20231213135256.145556b6.n.proshkin@yadro.com>
In-Reply-To: <mj+md-20231208.174204.32403.nikam@ucw.cz>
References: <20231208091734.12225-1-n.proshkin@yadro.com>
	<20231208091734.12225-14-n.proshkin@yadro.com>
	<mj+md-20231208.174204.32403.nikam@ucw.cz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)

On Fri, 8 Dec 2023 18:44:23 +0100
Martin Mare=C5=A1 <mj@ucw.cz> wrote:

> > +    if (!csv)
> > +    {
> > +      printf("Error while saving %s\n", path);
> > +      free(path);
> > +      return;
> > +    }
>=20
> We have die(...) for that.

I think that die() from common.c is not suitable here, as the utility at th=
at
moment in the code still can and must free up resources malloc'ed in the ma=
in
function.=20

> > +  char timestamp[64];
> > +  time_t tim =3D time(NULL);
> > +  strftime(timestamp, 64, "%FT%H.%M.%S", gmtime(&tim));
>=20
> Please use sizeof(timestamp) to make the code more robust.
>=20
> > +  char *path =3D (char *)malloc((strlen(dir) + 128) * sizeof(*path));
>=20
> Please use xmalloc().
>=20
> > +    sprintf(path, "%s/lmr_%0*x.%02x.%02x.%x_Rx%X_%s.csv", dir,
>=20
> Please avoid plain sprintf() everywhere and use snprintf() instead.
>=20
> > +    for (uint8_t j =3D 0; j < recv->lanes_n; j++)
>=20
> It's better to use plain integer types ("int" or "unsigned int") for
> loop control variables.

Everything else will be fixed.=20

Best regards,
Nikita Proshkin

