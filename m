Return-Path: <linux-pci+bounces-43999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1844BCF3056
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 11:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15ACC300C347
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 10:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EA63161A4;
	Mon,  5 Jan 2026 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPBahxkD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6D821348
	for <linux-pci@vger.kernel.org>; Mon,  5 Jan 2026 10:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609605; cv=none; b=IF0CLoXiohLScPT8/YadpzZLEu7DMfR0jJpGM47l+EwvPR90lLFu9rGyojuLK0YYRedA7zNQYbwwlhHyB6GaFoyJjzkrmIuK+NhgyJYo99jQm0lp+rPsIxKbSxy1v5k/wVtzst/Pim9Mu3uOo9EzXqI93Ais243cLvN24j9eu/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609605; c=relaxed/simple;
	bh=ilQVyanHgKsLWkZPGkjqH6wvmpNb1DelmMugaEdB5jM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPOPfccDctvIybNlM1nO0XCQZfcwh1uKBVHn5YIwvTe0OhznYJ7bj9/UHJ9vz2n4qaP6wX/kc6KLAvSYysWuxlLpy48lO3ZwLOEDrcXbYeTqT1s4UzFpNW4kY9/C73ObPTnhXGRJ+l3PgG0zAl5oeC6SXVG8w0J3EsRw3A84ekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPBahxkD; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc144564e07so395834a12.3
        for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 02:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767609602; x=1768214402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilQVyanHgKsLWkZPGkjqH6wvmpNb1DelmMugaEdB5jM=;
        b=TPBahxkDEzxpIldCY4B48Wn0U0NjzwIRbzpxV8VdgtEolAf7SDrhIa1TmNAYW6ytEL
         MdFu0LTgkLyGgbi9UQIBVVUlnV/QfSD3GICWA6Hkpa8AjmWhr71O2TwGAQv2eDhDebYd
         p4iITY36D8esuBSU02dRVLHpvlWikGcDejkfpANOUxejXnfB/V2oDJfYG2gUOP28/0ZU
         9YhmIRHHsi0oW64Q958RraaJxBx8v1ufnPCHwaMWExcDEnZ+6KDCNggCFzma5s4abq5y
         2+mRBT1JLftMEa6C/V1oLDRgIwMOVNlIh+2J7DcMKlW7AdJbnC5KghBWwo6fBJ4a9mkh
         a+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767609602; x=1768214402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ilQVyanHgKsLWkZPGkjqH6wvmpNb1DelmMugaEdB5jM=;
        b=dtIrrEGLi35C0QdkW5Jakcbpot6W/23nwqicAdeNU846w4VJzgHqNENUtcA5LmTQMh
         l6vm32Zj8/kDVdvK/pbKXkoz3x3rZwkwgCbgBwTIc39he0XQ1kXNZ6km1eNIALuUSkc2
         uxaUcF4n49+QTVIqmSqyd99VAYFZG3iSJDjOkd4Yzu3qxxGPqfCJIkOUZgYM/bUfE61D
         urKzkQhWYX1XDWD8r/3I6duIkqessxhB8+biNlCngjpQpT2DbwUJ4wtaWyk7UqA4m8mr
         QdX8/4KFg6p0BPZrshiIP+TMfIz/DUj97yZ0hwfzzbHRa4/xoj0nAroYn+0Ml/k3gA/z
         X1Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUaC0u8G0OrNKCwF9xBFWKcuE6JJYbRrFjpPY5Swp90JkcZwb3eRwACW1kpzLcJfE4OuG1Lod3EB0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH1yVRS/+V5X6vEfkKZlUf+PM6mod3IqPQtLqFEi1GRpjlbw5r
	yBcXy7QY75rkv/syQpzBbt823CJaBWKGQC0GQHtnYUVLxJ/14z7acu4P2jrRrXJMUUtANDPIjXX
	IObEWvYoQmmbSjBsKVSqk31tGYJpT+pA=
X-Gm-Gg: AY/fxX7805NMF+kzvQj+IEHAoi4Le0eLto5E6BAns7bagfoqNkvOzCFlDDOEWXrPP3k
	xSuQP2V/6ZrBZxrdLCXoMngpo542sKpYmtkPRnJHr01VTLYys0EbYQwga2RlujoJI1jVTUg3dYe
	4ndt5MbiElImxq2Vl1umaF4NXCAWCh/Lz4+M5rAhWeBUJzgMYr7Fycp6nDzYHQJUNHTPTsK1Ykx
	hchEe3idwNlJJobXHOnBNDIktYIlyyDBLGqtZHXkN2Sk8pcWAJj5gzDlXNKXxPAr9GvqCIh6ROR
	E9kR/+x6dwJ9reL5S5uptOGlfyDaP/NwhApLA+oU6cuK8tTwIBWbt8BQjtv/qa95Cd84u7+9EYO
	o7Rpt5QTEsGs4
X-Google-Smtp-Source: AGHT+IFW2rQaG24jjJapMA2YCS5ndIcCTUrcLoVwM07bEOEYf1H++r47YjXTIrY1jYLwOX3qoKgMykSxPiszDmOKty4=
X-Received: by 2002:a05:7300:80cc:b0:2ae:5dd5:c178 with SMTP id
 5a478bee46e88-2b05eb787b8mr24225253eec.2.1767609602464; Mon, 05 Jan 2026
 02:40:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103143119.96095-1-mt@markoturk.info> <20260103143119.96095-2-mt@markoturk.info>
 <DFF23OTZRIDS.2PZIV7D8AHWFA@kernel.org> <84cc5699-f9ab-42b3-a1ea-15bf9bd80d19@gmail.com>
 <aVmHGBop5OPlVVBa@vps.markoturk.info> <CANiq72=t-U8JTH2JZxkQaW7sbYXjWLpkYkuMd_CuzLoJLbEvgQ@mail.gmail.com>
 <DFFV41VPS2MU.3LHXU4UKITD0U@kernel.org> <CANiq72=fFZpWJ9BvHEBqi4chZO3rFo8+-F9=myW1f_JzJ0PNrg@mail.gmail.com>
 <2026010520-quickness-humble-70db@gregkh>
In-Reply-To: <2026010520-quickness-humble-70db@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 5 Jan 2026 11:39:50 +0100
X-Gm-Features: AQt7F2oJSnCa_SxWh-jZOT4jqarKH-djdmAAEP18_oI9iQTalSPqljHbD4ecNRg
Message-ID: <CANiq72nrPiTmuFStm5fmOZZM8e_4TGHFyC_77+cSqPp8yC8nUQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: pci: fix typo in Bar struct's comment
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Danilo Krummrich <dakr@kernel.org>, sashal@kernel.org, Marko Turk <mt@markoturk.info>, 
	Dirk Behme <dirk.behme@gmail.com>, dirk.behme@de.bosch.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 7:25=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> It all depends, sometimes we can handle file moves easily, sometimes we
> can not.
>
> But really, why is a comment typo being needed in stable kernels?

It isn't (well, it is not just a comment since it does end up in the
rendered docs, so it is a bit more "visible" than in a comment, and I
imagine some projects reasonably treat them as a fix, but still, it is
just a typo).

We discussed this years ago when I noticed a typo being picked up by
stable since I wondered why. On my side, I am happy either way -- what
I currently do is explicitly tag the ones that appear in docs. That
way you can decide on your side.

For the others (the ones in comments), I think it is not really worth
it to even figure out a Fixes: tag etc.

Of course, this is for trivial typos -- for something that e.g.
completely changes the requirements of a `# Safety` precondition the
story is different.

Cheers,
Miguel

