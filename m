Return-Path: <linux-pci+bounces-43973-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C5CCF10F3
	for <lists+linux-pci@lfdr.de>; Sun, 04 Jan 2026 15:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEDC73001966
	for <lists+linux-pci@lfdr.de>; Sun,  4 Jan 2026 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998F72066F7;
	Sun,  4 Jan 2026 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4HMWNRM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658AE14A4CC;
	Sun,  4 Jan 2026 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767535702; cv=none; b=oWuKJFesKf7VKFMdlHkp2GuvUJJHgYRgeYYN7B1vV3B80ycgENes0ZF/fb/kxZ3YqsyT/BRh07OUQC46DR/bPHw+QMEwvsYh1pVxKHq+lgE28k+BGczRK8+TM9hgg0t7x/VqWkNvxbZipWthQxcBYBGNCZpBsvNECq9G9werkvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767535702; c=relaxed/simple;
	bh=7M/pNScVgxaw18c6W7QeMkytNy3thIlhQApd5pkeZnY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=jifw0xTQVLYOHGN92ZuK5Msizflh2TMnLy6TmkvnZiLWuso0I6LQS3NQNOZmVo/jh1llgj5E1tyvfah+6pvepsWvM5UWX540KOeUYmmrul5oFYzHs+2c4UXGN1alBxKu1nhhyniMHA8C2w7Hf9vKEW4BE9Yvh8udTMs5gJsAick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4HMWNRM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF06C4CEF7;
	Sun,  4 Jan 2026 14:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767535701;
	bh=7M/pNScVgxaw18c6W7QeMkytNy3thIlhQApd5pkeZnY=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=V4HMWNRMHV1V4yd9NEAUY9e7RKTQrRyr+12YFdbD2HbwkGckjiwGOSbmUWV10cHBQ
	 f1eYzSH2qyyfPwl1dI9eubiWOoc8KV5yj1YbW9JbCDxKnr3rBsHZQGZCUu4PFh21hN
	 bZp0ezOTPNoU2IsPV4TJllqr7gG98PKN0R4He2X4TocSEsIvoAz8foeA90CLKON4hg
	 wRZrkwaWc2+FnkrcPzQSKTAtK9DAncdT40dsNOM6tFvZGIZEi5KHaS+OeyH4I16rXP
	 CPlyzwt1nmD9gp/5s7X6EBHUE2NmalNUuLcDm/tjwHhaWtzqNiOtz+9GGPOfiD3r2s
	 0otnCz2aebUGw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 04 Jan 2026 15:08:17 +0100
Message-Id: <DFFV41VPS2MU.3LHXU4UKITD0U@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 2/2] rust: pci: fix typo in Bar struct's comment
Cc: "Marko Turk" <mt@markoturk.info>, "Dirk Behme" <dirk.behme@gmail.com>,
 <dirk.behme@de.bosch.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <stable@vger.kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>,
 <gregkh@linuxfoundation.org>, <sashal@kernel.org>
References: <20260103143119.96095-1-mt@markoturk.info>
 <20260103143119.96095-2-mt@markoturk.info>
 <DFF23OTZRIDS.2PZIV7D8AHWFA@kernel.org>
 <84cc5699-f9ab-42b3-a1ea-15bf9bd80d19@gmail.com>
 <aVmHGBop5OPlVVBa@vps.markoturk.info>
 <CANiq72=t-U8JTH2JZxkQaW7sbYXjWLpkYkuMd_CuzLoJLbEvgQ@mail.gmail.com>
In-Reply-To: <CANiq72=t-U8JTH2JZxkQaW7sbYXjWLpkYkuMd_CuzLoJLbEvgQ@mail.gmail.com>

(Cc: Greg, Sasha)

On Sun Jan 4, 2026 at 1:45 PM CET, Miguel Ojeda wrote:
> On Sat, Jan 3, 2026 at 10:16=E2=80=AFPM Marko Turk <mt@markoturk.info> wr=
ote:
>>
>> The typo was introduced in the original commit where pci::Bar was added:
>> Fixes: bf9651f84b4e ("rust: pci: implement I/O mappable `pci::Bar`")
>>
>> Should I use that for the Fixes: tag?
>
> I would add both, since it was added in both and thus different set of
> stable releases may need to fix it differently (i.e. before and after
> the move).

In general I prefer to only add a Fixes: tag for the commit that introduced=
 the
issue.

> In this case, from a quick look, one is for the current release, so it
> doesn't need backport, and the other would need a custom one (since
> this commit wouldn't apply) if someone wants to do Option 3.

I could be wrong, but I think in trivial cases (such as code moves) the sta=
ble
team does derive custom commits themselves.

@Greg, Sasha: Is this something you prefer to do or is it something you jus=
t do
because it's easier / quicker than to get back and ask for a custom commit?

Again, I could also remember this wrongly, but I think I just recently revi=
ewed
such a commit from Sasha. :)

>> Should I do that in the same commit?

That seems reasonable in this case, please do so.

