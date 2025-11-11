Return-Path: <linux-pci+bounces-40929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D67C4EE75
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 17:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2316234B892
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 16:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28FA255248;
	Tue, 11 Nov 2025 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdfVg/45"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFE323D7D7
	for <linux-pci@vger.kernel.org>; Tue, 11 Nov 2025 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876856; cv=none; b=oAt0VirHf+eA6bZEdDmfrkst80kxI456XezIywQ13mU7eOSBa5jYv44SuxeMIOMF432LwBS0zmd8yNRhJ8e0WTkeJ+MAWdc6V+6+1hkj6pS8vYvdWQbMEmo7NNLdmk5sEuriNdsj0eBThK/7ne/f5gGWdLUcjQMSzDAo6RieA0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876856; c=relaxed/simple;
	bh=Hj15vhnGVkYFkb006HoEXW3Y3fjrc7qOYCUsPmdrJoM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZCMfzwOBCi9R49XNJYWcjHKNABGPPNUYx+HUGklN4M1xwr3lew7kF82mClj7U5j9eGVEBChMsjVNGiS98XrnuAYhbf5CWTqnw2pKJH1JcbaY7fDI/I1gpJC05RrAFDO1psQx8ektH/g3zUa4ivknyUPgL1PK6BgIgWytG7BMGTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdfVg/45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814DCC4CEFB;
	Tue, 11 Nov 2025 16:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762876856;
	bh=Hj15vhnGVkYFkb006HoEXW3Y3fjrc7qOYCUsPmdrJoM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=pdfVg/45cOfAjxNlg3H4c8jnoFar+xRf8EGHOvugQg3XSR7VIJlihZowckTa1EnYQ
	 +UCXVGakMgT9Y/0w0/gHXtS02okmJfi4McL7JsmxOeLH7MIJbbKRuCNpmZR/hvr9qW
	 5q1VKXH/QcAKzmBHOKJvbDyHlvgYFc9XoM2xT/Wnv8ciPPo3eis7famZsaGBvSRAVR
	 XKs5n2KNlNYGslSjJsFMfUFnddlE8PyFrFW/TKpbD7p08nlAPz6xpi0oG9dTZ1gQhI
	 kFSMEfJpS2emVnjJcNTcMR92poq1ZCuFzlBelWFfeK71TAVWvthlNVi3ZinGzd33j4
	 078SD3dvO4edw==
Date: Tue, 11 Nov 2025 17:00:55 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Mahesh Vaidya <mahesh.vaidya@altera.com>
CC: joyce.ooi@intel.com, linux-pci@vger.kernel.org,
 subhransu.sekhar.prusty@altera.com,
 krishna.kumar.simmadhari.ramadass@altera.com, nanditha.jayarajan@altera.com,
 Hans Zhang <18255117159@163.com>
Subject: Re: [PATCH] PCI: pcie-altera: Set MPS to MPSS on Agilex 7 Root Ports
User-Agent: Thunderbird for Android
In-Reply-To: <7236b092-5b5d-4300-985a-4604572886b2@altera.com>
References: <20251110170045.16106-1-mahesh.vaidya@altera.com> <aRJFzI-VCqDeEqTN@ryzen> <7236b092-5b5d-4300-985a-4604572886b2@altera.com>
Message-ID: <E58310CF-B82F-4BAF-84C4-44AA0FE23353@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Mahesh,

On 11 November 2025 16:21:30 CET, Mahesh Vaidya <mahesh=2Evaidya@altera=2E=
com> wrote:
>
>On 11-11-2025 01:36, Niklas Cassel wrote:
>> [CAUTION: This email is from outside your organization=2E Unless you tr=
ust the sender, do not click on links or open attachments as it may be a fr=
audulent email attempting to steal your information and/or compromise your =
computer=2E]
>>=20
>> Hello Mahesh,
>>=20
>> On Mon, Nov 10, 2025 at 09:00:45AM -0800, Mahesh Vaidya wrote:
>>> The Altera Agilex 7 Root Port (RP) defaults its Device Control
>>> (DEVCTL) register's MPS setting to 128 bytes upon power-on=2E
>>> When the kernel's PCIe core enumerates the bus (using the default
>>> PCIE_BUS_DEFAULT policy), it observes this 128-byte current setting
>>> and limits all downstream Endpoints to 128 bytes=2E
>>> This occurs even if both the RP and the Endpoint support a higher MPSS
>>> (e=2Eg=2E, 256 or 512 bytes), resulting in sub-optimal DMA performance=
=2E
>>>=20
>>> This patch fixes the issue by reading the RP's actual MPSS from its
>>> Device Capability (DEVCAP) register and writing this value into the
>>> DEVCTL register, overriding the 128-byte default value=2E
>>> As this fix is called in driver's probe function before the PCI bus
>>> is scanned, it ensures that when the kernel's PCI core enumerates the
>>> downstream port, it reads the correct, maximum-supported MPS from the
>>> RP's DEVCTL and can negotiate the optimal MPS for the Endpoint=2E
>> Could you please review and test this series from Hans:
>> https://lore=2Ekernel=2Eorg/linux-pci/20251104165125=2E174168-1-1825511=
7159@163=2Ecom/
>>=20
>> It tries to address the exact same problem that you are describing here=
=2E
>Thanks, Niklas, for bringing this patch series to my attention=2E
>I tested it on my hardware, and it resolves the issue for me=2E
>
>Tested-by: Mahesh Vaidya <mahesh=2Evaidya@altera=2Ecom>

The proper way is to reply with your Tested-by tag to the mail thread of t=
he series that you tested=2E

If you are not subscribed to the linux-pci list, you can click on the "mbo=
x=2Egz" link in lore thread=2E

( https://lore=2Ekernel=2Eorg/linux-pci/20251104165125=2E174168-1-18255117=
159@163=2Ecom/t=2Embox=2Egz )


Kind regards,
Niklas


