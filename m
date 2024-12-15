Return-Path: <linux-pci+bounces-18463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA2A9F261E
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 21:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9DE164901
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2024 20:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1821865FA;
	Sun, 15 Dec 2024 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F07urLf3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A7A282E1
	for <linux-pci@vger.kernel.org>; Sun, 15 Dec 2024 20:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734296172; cv=none; b=KeObMxQkpPPLYgfH9vUmm4qEJqPJ/FerLhpgPUUkGyYdymzgZ1UP7U6RLB11MKWpMIVYzTYrdHonFRGvN1xz1N7Akd1IrZoCK9W/1gl2AV3W1CXnMUan5fR/IKMEaXCBibKjNtQKLyrbzUvhntqt5g8Ht4joT3RdkH3TUSfEZkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734296172; c=relaxed/simple;
	bh=OefqH9KyeVnz2ltna++cgeutHsjNyzYoIL7PdziEraQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c9jFRNENO9IdxQUG8XDeCx32Qn8jtI6uc4TLloV9XNjWoNgIbEJoL7nEGtT7N/iCV/4jgPZtEPRCTG+QCs4DshE9t+Uhoyci0u+VhAWSXCIsfWO4BLlAEMjHoMSs0CkGrCLqgXzt0zui88Y8Utzw1mG9Y3GINxKtohlGkU2rbx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F07urLf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049ACC4CECE;
	Sun, 15 Dec 2024 20:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734296171;
	bh=OefqH9KyeVnz2ltna++cgeutHsjNyzYoIL7PdziEraQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=F07urLf3BSpzITROsUUCvHE6GdRjjc99VNZyylBorfEPjQl9To5VbdbBvAyCoFAdX
	 nvHGxHd4WpRyx+KhtCeWBz/rJOEYbKflm5Ks9e9vYHZZxwtBZLm0co3G4o9cUPoAJk
	 Dolmx6OvaOroz//uJ57NYMXsvGfJG8sOqiIyepeCZVQsXhvyy8woxFOqKulmvRK60A
	 vmQnI3v5wyxMR3RNsyUkdahA4oKQwJ3YpMhaaKoADUaIBBQelIBI5Zh2HKENyoBVEC
	 xhctRTbqMVIDf4VLfMVKVffA9QQPOihpqk69S59NyGPYlFKGW/RdZ2aDT6MnAOAViN
	 ndHfIm+tHjs8Q==
Message-ID: <d29a11adc3c9a249f774547b430fd9b2d4e7b555.camel@kernel.org>
Subject: Re: [PATCH for-linus v2 2/3] PCI: Honor Max Link Speed when
 determining supported speeds
From: Niklas Schnelle <niks@kernel.org>
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Ilpo Jarvinen
 <ilpo.jarvinen@linux.intel.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Mario Limonciello <mario.limonciello@amd.com>
Date: Sun, 15 Dec 2024 21:56:08 +0100
In-Reply-To: <0044d6cd05ad20ec3a6ec5a8a22b6ab652e251fe.1734257330.git.lukas@wunner.de>
References: <cover.1734257330.git.lukas@wunner.de>
	 <0044d6cd05ad20ec3a6ec5a8a22b6ab652e251fe.1734257330.git.lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-12-15 at 11:20 +0100, Lukas Wunner wrote:
> The Supported Link Speeds Vector in the Link Capabilities 2 Register
> indicates the *supported* link speeds.  The Max Link Speed field in
> the Link Capabilities Register indicates the *maximum* of those speeds.
>=20
> pcie_get_supported_speeds() neglects to honor the Max Link Speed field
> and will thus incorrectly deem higher speeds as supported.  Fix it.
>=20
> One user-visible issue addressed here is an incorrect value in the sysfs
> attribute "max_link_speed".

Can confirm that I saw this effect on my affected Intel JHL7540 "Titan
Ridge 2018" Thunderbolt controller.

Feel free to add:

Tested-by: Niklas Schnelle <niks@kernel.org>


