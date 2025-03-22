Return-Path: <linux-pci+bounces-24435-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48427A6C7BD
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 06:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78DCD18996A8
	for <lists+linux-pci@lfdr.de>; Sat, 22 Mar 2025 05:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A763513B5A0;
	Sat, 22 Mar 2025 05:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujRRApW0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EF52C80
	for <linux-pci@vger.kernel.org>; Sat, 22 Mar 2025 05:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742621508; cv=none; b=uvKo+Oq01wR+CEnBn/RdLfgWclPaQ9MH02WhgUpKYfbrzRvEb5DjhMbXd8/BYMoaET0CazvpSwxfHW/6xb83ZpZVjVeLvp97sFOz39e1Ba4mspi4+ZD6h8XOmBgZjw1hZXb5VTQwElb9Q85Bzj8fmfBkD4HbMDLkIdoJfb7IpGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742621508; c=relaxed/simple;
	bh=tto1K1dR9V1JtvpnRN45tcxKtb070neecMqe+R+eYjo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=SO4w7zbTRZAcbKyLTvalfhhO1xbiU+E6ljqy3VmSSi9FVuilnSB67RAkZc7xLKhLkSyDEs5qBEoqIkf93RBOL8HL2cJ52Fb8Qr8dFct5epluhwlnCfUPzWBj2cwGntA5vr6eKcrYhMfxF10kJYh4Z786bvfRLl36U7WOVLjwh7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujRRApW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6421EC4CEDD;
	Sat, 22 Mar 2025 05:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742621507;
	bh=tto1K1dR9V1JtvpnRN45tcxKtb070neecMqe+R+eYjo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ujRRApW0jWuSjkwbM/dtGVmgbKM9sR8+omjj+a/hCjbWgYc1I7BToSkVtp2xaWBkm
	 wuw+ltIy0ykZ2UAgnqSMTiIDUZioE5IDYagMXPcLbWTbX8KBayza7KXd6ANahkCaUM
	 k7Gm7ZwFoatkrsA/2GLwF1X9DMFz7tSNQP1+NAACAocwbsd6fAFB3UUmSXKLkHGCIV
	 JoFNizn3+7PBFCL6fPuel5vq8uR9uJrcefMZxXqB4eURHWQ66diWRIz7yQxp71jl2d
	 RWSmR0ZIqk3zAENI5kOrt++Q6LWhM7f3Fn14COo5jwf9YHZ9FVMNnFKrVqE3iA6tsw
	 9Vu+5EMV8DAdQ==
Date: Sat, 22 Mar 2025 06:31:44 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/4=5D_misc=3A_pc?=
 =?US-ASCII?Q?i=5Fendpoint=5Ftest=3A_Let_PCI?=
 =?US-ASCII?Q?TEST=5F=7BREAD=2CWRITE=2CCOPY=7D_set_IRQ_type_automatically?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250322022450.jn2ea4dastonv36v@thinkpad>
References: <20250318103330.1840678-6-cassel@kernel.org> <20250318103330.1840678-9-cassel@kernel.org> <20250320152732.l346sbaioubb5qut@thinkpad> <Z91pRhf50ErRt5jD@x1-carbon> <20250322022450.jn2ea4dastonv36v@thinkpad>
Message-ID: <2D76B56E-00A1-4AC1-B7B5-4ABEA53267CF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 22 March 2025 03:24:50 CET, Manivannan Sadhasivam <manivannan=2Esadhasi=
vam@linaro=2Eorg> wrote:
>On Fri, Mar 21, 2025 at 02:27:34PM +0100, Niklas Cassel wrote:
>>=20
>> I'm really (honestly) happy with whatever solution, as long as we, once=
 again,
>> handle EPCs that only support INTx, or only support MSI-X=2E
>>=20
>
>We will keep your old series as it is=2E
>
>> (Because ever since your patch series that migrated pcitest to selftest=
s,
>> READ_TEST / WRITE_TEST / COPY_TEST test cases unconditionally use MSI, =
which
>> is a regression for EPCs that only support INTx, or only support MSI-X,
>> which is the whole reason why I wrote this series=2E)
>>=20
>
>IMO, the regression could be simply fixed if you have removed the ASSERT_=
EQ from
>READ/WRITE/COPY testcases=2E
>
>But anyway, all good now=2E Thanks a lot for your patience in educating m=
e :)
>Really appreciated=2E

Don't say it like that :)

I understand where you were coming from=2E
I think if we designed the API today, we would have kept it as one ioctl, =
and user space could have provided the IRQ type (and/or auto) as a struct m=
ember in the struct supplied in the ioctl=2E

But, considering that we already have PCITEST_SET_IRQTYPE as a separate io=
ctl, I think what is currently queued fits the current design the best, eve=
n if it is not a "real" IRQ type=2E


I still need to send a patch that fixes the kdoc=2E

BTW, can all Qcom platform raise INTx interrupts in EP mode?

Bjorn did not like that I added intx_capable to epc_features without havin=
g any platform that sets it to true=2E I'm quite sure that many platforms c=
an raise INTx interrupts=2E
If all Qcom platforms can raise INTx interrupts,
then I could set intx_capable to true in epc_features in qcom-ep=2Ec, to a=
ddress Bjorns comment=2E


Kind regards,
Niklas

