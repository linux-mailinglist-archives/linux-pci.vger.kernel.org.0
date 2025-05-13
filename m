Return-Path: <linux-pci+bounces-27648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E03AB58E6
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 17:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DEF616D669
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23632BE111;
	Tue, 13 May 2025 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgpqreaV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E052BE0FD;
	Tue, 13 May 2025 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747150876; cv=none; b=MkDwvOATP5zWk5fu5pBcE2CHnU9qGbOVW0Xu7HudBJGY2DeXAbkyshb5e2hJSncA8jGLRPNhCaqQYl5tUfE4mAsyzR8U80ODLMNHNbAdSQa83Nx0RI6+mU8jknurXGCxTyXMJMfjbAje+UsBq6lHYIPKBqc0Usj9NCA+Er9ljSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747150876; c=relaxed/simple;
	bh=aGuVdlcwNSWrVFVeJHxewoF0jDxYsFRpF94u30GXHuQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=CsGa8J/2BmcUY9SiNt8VrRDJBmRqA4uAKKQ9Lw/mnpkkrbvQreyQQwX5TaL+qVqg+9uBz/9xi71nJoTUYmKr40BIiR313hm9dvkvgkcOgbYnieISEOv9vIcxjQFPBxdWlHaO+/MoWWqdbrm8Tn1mkMd/DaNRFlboOpfbnf5yJxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgpqreaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55111C4CEE4;
	Tue, 13 May 2025 15:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747150876;
	bh=aGuVdlcwNSWrVFVeJHxewoF0jDxYsFRpF94u30GXHuQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=AgpqreaV5EI5MfmFRc+1/q30M0vUVJClJ1WGDWsa59yBloMkKxSqjlT9XO8bqupxD
	 74lTb8N76vJJQ7hvydQNNdp4KbIj3A6Ysv3zMrkOXn3qnYlvoD6C7CMcIBEyQH77Mt
	 hfGrbp07AdSeUNeY63zncLzuxkYsVkPK8d7vwcVTtiwlhFmZY2Gy4O0AfX6sFyH+Yj
	 0oEAdmXZ/qjzWKV6VjLuop4q8pNZmBpYgBjHjTJlZ5z22WzrPJ8ZXRsrhnCVlXTqdy
	 AsR/Y3aWyRkPSN182EaXc2/OYgW3jr1FXhLdv8kxXiC0uVRE6w47MNPVr8ltBGKBld
	 vGc350kmMTdYQ==
Date: Tue, 13 May 2025 17:41:15 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
CC: lpieralisi@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BRESEND_PATCH_v2_0/3=5D_Standardi?=
 =?US-ASCII?Q?ze_link_status_check_to_return_bool?=
User-Agent: K-9 Mail for Android
In-Reply-To: <d484701c-8a58-4249-a647-d7f06075f7b6@163.com>
References: <20250510160710.392122-1-18255117159@163.com> <20250513102115.GA2003346@rocinante> <ec54f197-acfe-43f4-b5dd-d158d718c8e9@163.com> <20250513150423.GB3513600@rocinante> <d484701c-8a58-4249-a647-d7f06075f7b6@163.com>
Message-ID: <BF391DAD-7E2C-44C2-9BE7-C1F7A2946575@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 13 May 2025 17:09:58 CEST, Hans Zhang <18255117159@163=2Ecom> wrote:
>
>
>On 2025/5/13 23:04, Krzysztof Wilczy=C5=84ski wrote:
>> Hello,
>>=20
>> [=2E=2E=2E]
>>> Sorry, this is also the first time I have done this=2E For other patch=
es in
>>> the future, I will do this in the new version=2E
>>=20
>> See the following:
>>=20
>>    - https://lore=2Ekernel=2Eorg/linux-pci/20250513145728=2EGA3513600@r=
ocinante
>>=20
>> While I cannot speak for other maintainers, I am going to change the
>> approach to the "RESEND" patches that I used to personally have=2E
>>=20
>> But, if in doubt, it's always fine to send another version=2E
>>=20
>
>
>Dear Krzysztof,
>
>Ok=2E From now on, I will handle similar problems in the new version=2E

While I agree that it is always fine to send a new revision (which has pic=
ked up tags),
having the RESEND tag is gently informing that the series might have fell =
thorough the cracks=2E

This information might be lost/less obvious if simply sending a new revisi=
on (assuming that commit log and code is unchanged)=2E


Kind regards,
Niklas

