Return-Path: <linux-pci+bounces-21019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F94A2D670
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 14:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB0FE7A3ED8
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 13:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DEC2475E2;
	Sat,  8 Feb 2025 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ts+0NV/w"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C1024634B;
	Sat,  8 Feb 2025 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739022142; cv=none; b=otR7BgzDFioAO6hfSHmRH9Hm+DdIrTAewOJuxgDGAB+MfTyjKqgXRyhJckss+eSfnlDaPlhuu/Q3Ry9RgyeL/bTMSColUO/HjdZhAlX+tyrV0fbbFdlOJarrt8O9eqVXvVRUW+hy46KbOG64o0W3SqSfhk9ub+KvjIBFNALyI6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739022142; c=relaxed/simple;
	bh=ngMN4AfYaipZpH7nNPiOSYeIhrr4AomcMNkVmcAm/w8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tUTW0QESSbMxwpE0b2s/nfDM9tXuPJc1ZFm08ro5aT3bLjvppbG9AEdCmJVhmvVEFVuJW0G7YrEXe1AsSbCjF9kGk0MZxBOPRalIqjB6rqCLAUb5ReI2r630oFqbBAymAds2k0bXcvBpcLSBY1nyAGny0EWwVu4VDIanRFet6ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ts+0NV/w; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1739022138; x=1739626938; i=wahrenst@gmx.net;
	bh=ngMN4AfYaipZpH7nNPiOSYeIhrr4AomcMNkVmcAm/w8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ts+0NV/wBmL5QHLH3+9mQVm2rik2AXodnayQNhYUmhMb89ZeVB8LWQcwRZbbC4AZ
	 C65wrfBlS80jYGBD/uG0ir75MDI/cqmCustTjdKhBX6NJNC2/0nl6rQN+cVJWr/dN
	 /qdBVYX1URnv5hJYors7O1kOQo89VglFL+8RTtImzvwv33Xi1PP2NIuaaFhjcw6Xe
	 W7hyZJoiT9VHc36efMdBnHzW3/AJs7AlHcu4i4IYIP8zFumJF6qIyt8CdfsnWjxm9
	 hJ7A0XYJ6LR3Eg/mQRkhSM8DQj2a1OI0ww9M5xUiXb5QU/zJLWtugQnSxvVOErzQt
	 hJuferDzxdtQrQAOFg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MXp9Y-1tuzeI2DYS-00L6yO; Sat, 08
 Feb 2025 14:42:18 +0100
Message-ID: <ab88fe2a-4f59-47d1-855b-517d98773f3c@gmx.net>
Date: Sat, 8 Feb 2025 14:42:15 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/11] arm64: defconfig: Enable OF_OVERLAY option
To: Andrea della Porta <andrea.porta@suse.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij
 <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
References: <cover.1738963156.git.andrea.porta@suse.com>
 <49da5d0cf961fef23a1622253825443eb51d660d.1738963156.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <49da5d0cf961fef23a1622253825443eb51d660d.1738963156.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MqewR4qhxQkLVlA/5AQd8FA2Y6QAAPMgpTkmIvKSeA6cgOvvxNi
 IwPq/45hXyYwz0U19B9/ZViLl+kDRwuUyp/jZ5+oMkX5hQh4sgUIiu9/9JpPa65SQx566H6
 22SPhcJScjhWewRBZrGaj1nto68z8S2LWk0HLMta3zZA0nXgrRT48zsbbp2CvpiMu0lF8xx
 K4Fjpli2GbeAMgx79RrmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1K/4gpxF1gA=;i/nVL/nCb8vzm9lfLz1l+L8C0V9
 Bj+A5yOpr5js2Zs2Hqcsw0M7tlmhSCn0cV6xjboP1kjOOqjHtH0n3+8ux3NHcWhghu82MqBB0
 u+WgfslQrpAdsjdgCsS5A6F3M18zxhMQ38kuBRcfh3v2e9wCatAMSzBisyFFW5TSSiOb+ZRHQ
 /C4xmKr6ljKpa9JMOlw+PqXACZ7o6Owug1m0GUIQYOYP0VLFnvTZZ9bUIqqAWLXwyHLpHtMTA
 JVAbqaqhFv62JSxnZJJzoqpfPEjq8njZcYwZbdV5OA4gyEy9tpWuu5qDC1Di7ZlFcuzVSJ5hw
 h1+ao3+1MUdiTt7pxrP5CW6bf7F91taRzf5EqnqANBr/xA9e+OGU1SQqBOQyEnsX560bo3cpF
 MEhqdwJ3sasCpO7pmcFrmxxAgPWPm4C8Tw1hjx5pyxSzVokEWmAlqCm7MkHn6HrwHHvVYdCmv
 xmEh/yzO/3I65k3SOIwuoWQ93aVlMWtplH1l50riqjJs9C9EAIo5axYnGwhS14872iaLWw6f/
 maILJrVu8lXg2Z+BXWfUvMJF7F4+nPX66OWa5F7ira3HGZ391V/KMXj6CCkRLKIo4gSvApohW
 RHB2hVrb6qGoF2EqFYsa66za8hbuY65Yu6RJ9MiJh4hNV7RncgiRWacmrLgUDrgdmDlAix93j
 kzXFQKMg48v+czo9/iYoiofie78kUot9XyJ00cuV2dald+ylr8wov+5MDCM5iuXrUwYp2eDRT
 osrZxXD2/8b37enyvrt0G20VKiFpKUTD9B8W73iVSZagQO6ch15sCC4iVGGbUKzyNNgB9rBu0
 n8mTMHPU5buYnAcCbpW8VvPlVtslSDgwBSrxlI8UR0t1mYEM7X/FygYFlo8xrCiYtmpBAcSUt
 PM3zOEu1sk3g4RK9V4Eox2HEsiekXeFO7jJ8AwUfJaY8yU4/P0ej9u2WZvJ88vT/2HD7x7rxb
 0OuZGpnIFN1Od/ZktIa/dinx8EtpNmG7e5XWWeaKEguh5Yl5TalHWXUbqfuBpwBP4mh22MMfi
 nsiSjCR4rTPtzbXKvnJG4n4Mtqn/q1Me3d7OAViXBUueIW1ZO2Y0zzeuHjpG3ntpC0Mi4dgbY
 CPGlLGfLG5DFAB+wtqRzSVZ5rt2YJQjn4j8JVwVlrOFSRMdbOXFk3AfkdokySP5g0D+eXiBpN
 g05YnMq0JhtH6E86wGwcXulmjNr3EkK9tZ1HqzTVRHiY0p+dp328uKg1i97GSIWy+kkb0PK4Z
 psuIo5YQJBadmEtZgU0upiVQ1Vb/JArDjSUIoznRQCBbTcmyZU3hlT5Wxpfx5AAFStRrChPF2
 s5L9sNLpqFQ0dhgM6iBcMcEDJBbqNWX4QQqycq+jkntfo1pXUS3P4f9nJLr7+Ur0D/0w3XrYA
 Dj4uThhpc/+6Q5YdMPySWpUFdL15CnueOOeM2oLhUuAc7vNProVYehtJSuNbIsBQogeZeiM1b
 bwHAxNQ==

Hi Andrea,

Am 07.02.25 um 22:31 schrieb Andrea della Porta:
> The RP1 driver uses the infrastructure enabled by OF_OVERLAY config
> option. Enable that option in defconfig in order to produce a kernel
> usable on RaspberryPi5 avoiding to enable it separately.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
> This patch is *OPTIONAL* since I'm not sure if OF_OVERLAY is a desirable
> feature to have enabled by default. It would be advisable to have it inc=
luded
> so that 'make defconfig' can produce a kernel config that will work out
> of the box on Rpi5, otherwise OF_OVERLAY has to be enabled separately.
I think this isn't a good approach to convince the arm64 maintainer.
This change is not really optional for the Raspberry Pi 5 and possible
users/testers/CI rely on a working default configuration.

So my first suggestion would be to provide a scripts/bloat-o-meter
output (before/after). Based on this the maintainer can better decided.

In case this change is still rejected, we still have the option of
something like this [1]

Best regards

[1] -
https://patchwork.kernel.org/project/linux-kbuild/patch/20200203184820.443=
3-3-nsaenzjulienne@suse.de/

