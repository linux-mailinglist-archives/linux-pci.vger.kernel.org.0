Return-Path: <linux-pci+bounces-17288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D94379D8C52
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 19:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD73169163
	for <lists+linux-pci@lfdr.de>; Mon, 25 Nov 2024 18:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72BA1BC064;
	Mon, 25 Nov 2024 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="l2IPbOZ8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735181B87F2;
	Mon, 25 Nov 2024 18:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732559880; cv=none; b=sm3EB3GsQIg/Ial+aAk0SI0vwzqy8IiuMp9Xwslw3YFU+Od8SlAjG2qT0W99IznbbOxMgOjHUwEm4sMXyX3GqZ2M6yvx9L7k/rxB+oTCosOvUmzcD6GVbQ9qwthLw6do0XXMWR3I5JcuNu+OAxzRXkP0HZIftbzfAkDaQZxy1HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732559880; c=relaxed/simple;
	bh=/Gr6t9ocBQeZBn/ggKREg8SSt92d4sIva6PWwF+sDAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H04ImvkAvAIcyIzkAH5uoxlHhgL3aCtWRj7pKMI5PxXQx4HxSUP8/ZMfxJiarYAzMLzTcmmG92bTSzBF3yAm4QW5iOseZTlRu97pJb+jgQ5zKWSrbPP8wsNwciuGMLC3PvgqPyVewkJ1FBYEC6m2ogexQ5Ajq+1p0JTmMpA004M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=l2IPbOZ8; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1732559851; x=1733164651; i=wahrenst@gmx.net;
	bh=/Gr6t9ocBQeZBn/ggKREg8SSt92d4sIva6PWwF+sDAQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=l2IPbOZ83yyVN5C62FVjQpg9L9T9I3PuqIQZGsYE0V7P8Ca0YrYHrg0QKqUOk6A0
	 nvivP/UBr9/rsKjFwct8ox3klXXgtNCquuen0CBcvBnRAcNtVtPL128N+iQc6kbxX
	 Utc0yXrXw1DVFLAmx3zm6OVhMLDe6ZnfR443AUX/a3yOMGXC5Ahn2hJWr3KT2VCV+
	 1UteyWwb2JhPRnmXVSWx7BLSEa7n6tqMwzbaZzjP9RE9SNPcDtws/Vwspqjirj5Fz
	 9plhQmZWnAgebASfLVMQM4yT8J6isRNVImNtIcuq6ddBIqCtiBYKgF6ZO3S2ITLz5
	 bO8f8yQ34lv4vjd5vg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.105] ([37.4.251.153]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLR1f-1synV20GfL-00Tt8W; Mon, 25
 Nov 2024 19:37:31 +0100
Message-ID: <3eafa938-0ca2-4228-aecf-fa85a6706dfa@gmx.net>
Date: Mon, 25 Nov 2024 19:37:29 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] arm64: defconfig: Enable RP1 misc/clock/gpio
 drivers
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
References: <cover.1732444746.git.andrea.porta@suse.com>
 <2292350a8bcf583129f93996c8a6ad5572813d9a.1732444746.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <2292350a8bcf583129f93996c8a6ad5572813d9a.1732444746.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:cw0mRjyGqPC7iEtwkdW1b0Idq/JJr/O/fH2smwdrV/GCTqk69Xy
 mEQmW4QY30EfEqAJDhDlsQKu5mZmys48AboknAavj0peWiC6NlTZz9Ex/tuO+cpq0iVl4I1
 cG5dyAykgemkK1UoFVvl0aokepZrmyLQTnDbE0xgdSo6wF1DTM9qMPAGhlfnxM2bDlAUMxv
 rB/PfGLfijJLqSOf1oQiA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NFw/cKnOJFE=;daKFu2pia/80N7+H6SoNzr+ZOrz
 zMz9kf7f/7Y1YCwyCYLXAARmNikFYr8XPybmGBNnGnPh0+uCKri64IDy8yKX8NxVm043+Gz2v
 jopKDLpYvAzwFoczor8aB4KbFXQWgwIkWxUF6YiRDBPWaqz8FrEFAxvXk3LsLlfNtbmpv6rCW
 iiCHMyX+cn0JhlApWvoJ2+zF4hrd51+wNXkLFfrKO7In0WTsMAMVdxOddHfuZHQIZ62HbglTJ
 N+8vmpY5/jGbcxoAJPNfLSliXMieqCj6mQj8died23KxQ2/kAH7p14Fn+JWkE0fOOklGmvpGk
 Bmoe3amZJPrUYPAPw2N5ldC1jDcS2AXY7HaiXwgcWzTXkJS/CH0G1QpeuGVzmMy2UsK8npK7e
 o0/QD5qpRoL71Nlb0UBDKy/YK+eseOxrBmEEIeKHgAM/+bXeHonOV+u+ByktX7BMV8ZmuxQSg
 C+YsxVuXrrUNPDy5UBs1VF7wPt+ArIlltaSKyjsXfh+i5BocqIP6OWdqsz8djWBtgLWLHiWsp
 dWLwhmJQ3bbYjpB3S2ZRmTcVVxXi9JYT/t8FeVRDh5DwN7x4esxgbvDXJ9ykBCYmJdEYRYDF/
 CG1WOL/Keon9d++OAdm47rCgKncXEwHWT2gtmWxjwE2aeGSlpclazKW4gXbmF38j6UcLWW4S5
 hlNZSXwm7/AtruQdTBKA2Ht71peJA2d2xkKjsIiCz+cFKtQDavO8+QgyfZRBzrC/T1D+y9Vub
 0Or8CWD58y4LRpev0GajmWFqQJxL99pBZGTK6doK/raLn0Z1eZl55AjQkCOQGCk5HtT4bjc2q
 fXbVKU7s+8FCHA1/H0zUlJrlGTrvnhVxhJGdtcoTk1QdGFLXel9dZdQwCAlZND7GyISqGApDW
 5lhDEzy04XDrf414hZzDAKcA/545oCuYSrgQWR9H3xttkt+8q6YQb7E4d

Am 24.11.24 um 11:51 schrieb Andrea della Porta:
> Select the RP1 drivers needed to operate the PCI endpoint containing
> several peripherals such as Ethernet and USB Controller. This chip is
> present on RaspberryPi 5.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

