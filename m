Return-Path: <linux-pci+bounces-21421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CA8A3550D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 03:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679F818901D7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 02:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6871B38DC8;
	Fri, 14 Feb 2025 02:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YCHV2LLg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9479C2EF
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 02:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739501390; cv=none; b=HTjM7hrIhfveEoX4VStn8xbMoSWoyYhSbQ5no8ZSRZz1MI+xTAUaHMMryuGBAT2HJ6iUBcOmGOFqgKJZ0vM8WI8cfI9pf90hupUQo0hBkmG+0/em3NAxEbomsElRXNw3e7WotY/M5oqbs3yfZNJVPhECVkXK0ll3mWiEPglu61o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739501390; c=relaxed/simple;
	bh=Xq9/DoUytjoxe56OXx3gs1q2FEDuzyuAr1C6wWdObHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWl8XU+98F4IoD8Oc2mo8Rj5F226Cl8ve9HJjmvTYZwuKG4b5HGDaf/NT4eMh+3jAErTnWxjRVJwB9Lpeop//Q9xBVXyT9Wzgzf0FHshOcCL6rEGop3okS8gCv8uNjm8pQlfjy1QYNFXCiMSdZx8H1Pig13aBeYj50yZHiR62WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YCHV2LLg; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5ded6c31344so1403049a12.1
        for <linux-pci@vger.kernel.org>; Thu, 13 Feb 2025 18:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739501387; x=1740106187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xq9/DoUytjoxe56OXx3gs1q2FEDuzyuAr1C6wWdObHQ=;
        b=YCHV2LLgsikcyDigIGGiyKS55ry0Ssi1vfM2gSNrGQjLyl2li7YvhBvMw6OEDKbUZB
         aqS7/xsWVcSD0zocXsRjm8N3rWsFHxpczmEoJBFTxjEMlWvlLgPMt8f5P3DnYzSehz52
         JEB4/KJGPTBOZOXjmUHSekZUMe0aJSzmdO8T8tE7A1Y01CKViKcUhB8ehBp9QP1svZ9e
         97XoH78ihV9rs3PmO8OKhuoTD6jR+7Fxv/hZ83cU3Ka6bQ53J2AOKb7ZsyWmbBBoTFts
         rlazubrSKh4abNyQVYhb2cI68heZ3O/Mx47vxewtxFD3kPv41RI7HuKGHfhdbDSH8usW
         UQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739501387; x=1740106187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xq9/DoUytjoxe56OXx3gs1q2FEDuzyuAr1C6wWdObHQ=;
        b=mCK7SpopwMp4Bme5VTmjYGldrSTkQIeqVduhdz0HAE4fIk+19cMbWJUrJnTIh40zlX
         87f7W8fEXQDIKYMuMhotURHU8kAVdSK64SCIuHlwQovOGwfHLvpo3H/C1daDpcysyVx8
         HZcRK7cEhwES+9oGLqkEjyMMkiKdXxX162sY7fZ1W6zEYNEeNeIluzLBKZpYbaTqj7Zo
         Y3IEaMohzUJ9N3B7/K0sgYGFeJgD6nr69/C8qMkdo1Webm5ZGTJV2ejDYciE7sexndSY
         EgeN2D0+2qiIdpo4/3MX/rZoiBxUQFLXRt56AHJo7eojzHG/v8rHh8Uz8ohkxTqQSf/t
         3Xfw==
X-Gm-Message-State: AOJu0YwPIOXkHjEhsovARFQIhCw/r4wy6bSas6DDy+nMjvHGBlEKvAJr
	2PGs4QtdpZ/tdpqfdotDbOlC3YCvgjWQ9LmKvjFD0B72+Kgd586xhODRLVQrRjC8OcHdGyd7W/T
	2HF52dPK7YGsHXpkQN2tNO5vCaJcyY8UqOmEt
X-Gm-Gg: ASbGncvhhOiOAVX/IGVmNdPIcpctXYNAaq99GcbOdgBHSpU0IBjO64EDwI7Wi7r07he
	0roFjWSIbiW13rAqVsxIgP26r5x1mbimVvX42obEM9CwIz7lKepffglYUQv0F59QmQ5ZLvg==
X-Google-Smtp-Source: AGHT+IGcELiDs0DFzhkMyQt2Bwj+Ihy0enaNsXbOwg7pzuLsvNES2wISB8hx40vMCxzVy84qS9E2/54ET9a9GZuNXIA=
X-Received: by 2002:a05:6402:13c9:b0:5dc:796f:fc86 with SMTP id
 4fb4d7f45d1cf-5dec9d4a4ccmr12357560a12.16.1739501386940; Thu, 13 Feb 2025
 18:49:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115074301.3514927-1-pandoh@google.com> <8f26a854-5d49-4993-a838-efec7270155a@oracle.com>
 <CAMC_AXXVQHZZFeDxsdqGzCuCS24iCZDHEZcbOppu9Vxvt-gH6Q@mail.gmail.com> <7eccf9a4-dda1-49a5-abcd-75f1a3a850de@oracle.com>
In-Reply-To: <7eccf9a4-dda1-49a5-abcd-75f1a3a850de@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 13 Feb 2025 18:49:36 -0800
X-Gm-Features: AWEUYZln_rkLzxyx5Rdw7keeyJVYk9V1Yg5ubxuJUGNP9GUKc71jhc6CNORwhV4
Message-ID: <CAMC_AXXGGjRy_GYWS6Y3Dd3nae0K3vw2yPNVom6YmQOLt7qkoQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Rate limit AER logs/IRQs
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller <ben.fuller@oracle.com>, 
	Drew Walton <drewwalton@microsoft.com>, Anil Agrawal <anilagrawal@meta.com>, 
	Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 8:00=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> I'd need to dive into CXL part and ramp up, but I think that's something
> I can help with. Does it mean that you'd rebase this series on the top
> of the proposed cleanup?

Yeah. Either that or you can append to the beginning of this series as
the first few patches are AER cleanup.

The former is probably easier depending on how large the patch(es) are
(i.e. I will rebase the ratelimit series on top of AER log cleanup).
It may even make sense to absorb the first few patches of this series
into the cleanup effort.

Thanks for the help,
Jon

