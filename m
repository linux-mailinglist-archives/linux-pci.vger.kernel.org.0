Return-Path: <linux-pci+bounces-44021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87222CF3966
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 13:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BD78309E47F
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 12:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C3E30F545;
	Mon,  5 Jan 2026 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQT898oO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B568A2F84F;
	Mon,  5 Jan 2026 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767616711; cv=none; b=ujnPFeVuwBARg7p4eT/DvqR36VGrzLaUIrfD1fo7DkvYvPT70bPZwJcpsxJ/1+XIEJpo3godIhp5fzQXALICiko253fL07Se+5LEOld8I3jylxtDlioMnmW/yMjoVNV4YAPufiyq/bgghIzJRSviSfYLxU1Du2sZhHjfb2dl8eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767616711; c=relaxed/simple;
	bh=3QGOZEd+/aLMEPGQFvaYlD74k4dh6Zh7WBpe16eIi44=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=cgLQEuDoPnR4PLAxOGNEEFDGjCk/dQHR2ptItXZ0ZAeQt1yeDiviYkGffbwv7YwD9mg8j6IOl836iUdf6GFfdJxiWbVRDuvjB2CIfb9hUq/6yzLFZU+7aqH8mWu1iqyOz00hmbNRljj6W7tIsUJi2ydAG1HMGUDFBC+g1PNykMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQT898oO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A67DC116D0;
	Mon,  5 Jan 2026 12:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767616711;
	bh=3QGOZEd+/aLMEPGQFvaYlD74k4dh6Zh7WBpe16eIi44=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=dQT898oOvvcnTcLYMEfDwVemX8VmvqaET/imVvIuspha7UFME7xp/XoMH4N0IrY3r
	 0QFrFA2FewZ/8Gl9y7KpfBxHz/1lmZddnOk/ZrhxyGsDAXhJRrHX7v9OJnQnPOJXju
	 2kJcVbbbfGVxrlcnB9aXcbn7cXWyExl2Ra8fOdtJ1yfzHVqJB8VNJf+4I3PKNIj5lP
	 06yaQoolkeo74Cs3vK6AFl8IEyNmBAqGX18CHDMWI5KoVJ3ybkl32zwcchsh19X5Pv
	 ynDBGhjm+FGouwxcgmg5IXU9dQjoCf71dkSooUEGeYMM3HcOA6nz+kuT68G/xWrEgp
	 sEZoQflqHzRig==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Jan 2026 13:38:27 +0100
Message-Id: <DFGNTT6HB593.2C2IGNSHV9B82@kernel.org>
Subject: Re: [PATCH 2/2] rust: pci: fix typo in Bar struct's comment
Cc: "Greg KH" <gregkh@linuxfoundation.org>, <sashal@kernel.org>, "Marko
 Turk" <mt@markoturk.info>, "Dirk Behme" <dirk.behme@gmail.com>,
 <dirk.behme@de.bosch.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <stable@vger.kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260103143119.96095-1-mt@markoturk.info>
 <20260103143119.96095-2-mt@markoturk.info>
 <DFF23OTZRIDS.2PZIV7D8AHWFA@kernel.org>
 <84cc5699-f9ab-42b3-a1ea-15bf9bd80d19@gmail.com>
 <aVmHGBop5OPlVVBa@vps.markoturk.info>
 <CANiq72=t-U8JTH2JZxkQaW7sbYXjWLpkYkuMd_CuzLoJLbEvgQ@mail.gmail.com>
 <DFFV41VPS2MU.3LHXU4UKITD0U@kernel.org>
 <CANiq72=fFZpWJ9BvHEBqi4chZO3rFo8+-F9=myW1f_JzJ0PNrg@mail.gmail.com>
 <2026010520-quickness-humble-70db@gregkh>
 <CANiq72nrPiTmuFStm5fmOZZM8e_4TGHFyC_77+cSqPp8yC8nUQ@mail.gmail.com>
In-Reply-To: <CANiq72nrPiTmuFStm5fmOZZM8e_4TGHFyC_77+cSqPp8yC8nUQ@mail.gmail.com>

On Mon Jan 5, 2026 at 11:39 AM CET, Miguel Ojeda wrote:
> On my side, I am happy either way -- what I currently do is explicitly ta=
g the
> ones that appear in docs. That way you can decide on your side.

This is how I handle it as well. For doc-comments I request a Fixes: tag to=
 be
added and leave it to the stable team to decide.

Unless explicitly requested by the stable team (which obviously did not hap=
pen
so far) I do not send separate backport patches for typos when the upstream
commit does not apply though.

