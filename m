Return-Path: <linux-pci+bounces-42474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A845C9B4B4
	for <lists+linux-pci@lfdr.de>; Tue, 02 Dec 2025 12:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C4C3A2675
	for <lists+linux-pci@lfdr.de>; Tue,  2 Dec 2025 11:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49EB30FF04;
	Tue,  2 Dec 2025 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikWyO8kh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BF730F93B
	for <linux-pci@vger.kernel.org>; Tue,  2 Dec 2025 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764674483; cv=none; b=ogkzrxNdIFjGXJ+bO8XJEmNRRKks7TcMXC5RdbPhfkOKRI53uj8pSqTJUcr1bWgY2wi4umZvpr/55DVxShjEaIK+vaN6Sr1GthvrUJGbJw0U6FykOVxl/00fthcyhmct38tRzlXUPeIu2gXzKCtIOTGjMjkLBgtE+OaglmZVoro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764674483; c=relaxed/simple;
	bh=ebI41iK5gjq0L5IRa7e/P/x9OhOy/cqTUUejIoRXkM0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=BkOtop7H9ob7JRSUaJWwTFtJEKqMkYRyVlYrXNLVxrVXbO7G5cDzZYDF+2aqyzCVgYZ1jbhnabtv/hhbEE0mXLUIAVHwlk45b+/EBwNVGKRzcjwwufL3dZD2ePza1Cz57P3Yf+Jb9PCycBsrccJBECqyyTugOg+0lWpnvmOZVJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikWyO8kh; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37a2dced861so51572501fa.1
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2025 03:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764674480; x=1765279280; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHGvFJa75lB1s5FOVY85+WmT8K+iTuEMFLumjxbx42M=;
        b=ikWyO8khZwe/qLfkusvEeIK9GVQGgt/sEtx7wdjlZaWa+/51MLaRa2wXNChRwbj3Cd
         V2lvMgM8hImInF3Cogr8oJ4jClQ2AXEK3JndZH2GW2ma+GM7h/gjLb6/gB+EfRjh5byP
         j796Eh5MQko0sFSTz3ruiHGLRJ3wNZZTTKv5Pwc9old9Dqnb9pjwkM6xRhzv/0G8MrLl
         ioYSPIpcgw7J3Aa1AEmFjeVWAj7+IgsB0oBglt2jD3M4n19eWtIRdwAEf3NzLH9qViW/
         XKhBrPA+U1A5VuxMWgJpVXkpVd55gUflHxwsfcWSjEQYbjT7qRfNzJJyUJNDCtMsKSB5
         A6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764674480; x=1765279280;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FHGvFJa75lB1s5FOVY85+WmT8K+iTuEMFLumjxbx42M=;
        b=ela15Or4/FFVIlIauX33OpVL9wm17/XmA9dsj8wj5No16byBRIJX6wQ4l8HYUodSC9
         SmfaViaecjXcEdERYxiU/BeTFcuZpc0/bUHcB/ZNDTNX8dQ2xZg579jkwDHnYBtKV040
         46ouTt/PQ65UdNqdhNGelH+ADn3enxVp3xsgkPfRUwoBg6m6aVfy5guYfVe0MUTv8mzY
         XXlIVTYiCoyitupabpAbjP9AUDKTF4TKWej/I5zGwTvf1k05sZW/1zdju7m7JdItGrNz
         rmobXXJV/ho69pvPWayE7rNEPrrZeWeJ5iRK7msAFR3MafvdSWuRBBzPS6qcvFFDBzBG
         dQmA==
X-Forwarded-Encrypted: i=1; AJvYcCW6ljW3jmCS9Tg2eXlB7zC9J4eumFLWdA0Tkz70VZ7hC65kt5J8adnBWg5GsX5AqDwWQ8/P45nMQ9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi8A5gfrOmvHLVcrp9te3oD0vnP3dczL80A8/JvKwTh9z8FruS
	z2Bkq9ps8xlJcUjIrEQN02hBW4rFPFXoWjBTtpy0ayGweov+QNQFRbv/
X-Gm-Gg: ASbGncuQgdatl/SWYTXd0p8dRkPEBcPD8c1HrrpOLgzzeEvUEWqoqc+1xcD0hGzeEFC
	2+3MYArS1RGGJgrv1TKSCo/AQeXvl40JLs1uH2bxQSHOfjlvZBF0C0NBaYLc+VwlU8/pKj4LqYG
	IQ7K8dCh629v4lsAAlS5FPYY0OpaYoKXMtnh0RQWy4nkN+Txv2TsSmAt6cS0/MwQWRwvUE0MokX
	VPg1jNu/s5xBkCaXg69MFKsNHNnruO5w0dKkpc76c4mwnTpugvSO9qZvXofQGzcjGExvocHKpOq
	I0a38IzkJOu5+wBQ3GkEF4G1fDzTQGRxRK2LKzdK1I4UIxEDr+fw9lNvYq6HqZyEUx2CSQxlUy+
	yy4HeOSCore8pKDgMGq0JGyXxpDKEgMIVTBXp2ptQUZdCspy6kdXMT4+wpK9PVJqu8RZPrTAcnN
	h2q+AhxSho1bCBQA==
X-Google-Smtp-Source: AGHT+IEAmVx71ofDJnqXMWdm5SDHhZDccJOhKRMoK+tDdSkd1NpTk5tba5l1eQx6flbKeCAUi9zshw==
X-Received: by 2002:a2e:9546:0:b0:37e:5208:e2d7 with SMTP id 38308e7fff4ca-37e58e4f776mr5336841fa.19.1764674479321;
        Tue, 02 Dec 2025 03:21:19 -0800 (PST)
Received: from [10.38.18.76] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37d236efc92sm37487261fa.19.2025.12.02.03.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 03:21:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------RTMpC01dN2Tts0K0800P0dVv"
Message-ID: <088af3ff-bd04-4bc9-b304-85f6ed555f2a@gmail.com>
Date: Tue, 2 Dec 2025 13:21:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/29] Revert "treewide: Fix probing of devices in DT
 overlays"
To: Herve Codina <herve.codina@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Peter Rosin <peda@axentia.se>, Arnd Bergmann <arnd@arndb.de>,
 Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 David Rhodes <david.rhodes@cirrus.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
 patches@opensource.cirrus.com, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 Allan Nielsen <allan.nielsen@microchip.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>,
 Steen Hegelund <steen.hegelund@microchip.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20251015071420.1173068-1-herve.codina@bootlin.com>
 <20251015071420.1173068-2-herve.codina@bootlin.com>
 <f74ab0a2-b74b-4b96-8469-a716c850e230@gmail.com>
 <CAL_JsqJDOYuzutMHMeFAogd5a_OX6Hwi8Gwz1Vy7HpXgNeYKsg@mail.gmail.com>
 <5cf2a12a-7c66-4622-b4a9-14896c6df005@gmail.com>
 <CAL_JsqJjm12LxpDg6LmpY=Ro_keHwnrWiYMLVnG=s_pSP4X2WQ@mail.gmail.com>
 <072dde7c-a53c-4525-83ac-57ea38edc0b5@gmail.com>
 <CAL_JsqKyG98pXGKpL=gxSc92izpzN7YCdq62ZJByhE6aFYs1fw@mail.gmail.com>
 <55076f4b-d523-4f8c-8bd4-0645b790737e@gmail.com>
 <20251202102619.5cd971cc@bootlin.com>
Content-Language: en-US
From: Kalle Niemi <kaleposti@gmail.com>
In-Reply-To: <20251202102619.5cd971cc@bootlin.com>

This is a multi-part message in MIME format.
--------------RTMpC01dN2Tts0K0800P0dVv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/2/25 11:26, Herve Codina wrote:
> Hi Kalle,
> 
> On Fri, 28 Nov 2025 10:34:57 +0200
> Kalle Niemi <kaleposti@gmail.com> wrote:
> 
> ...
>>>>>>>>
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> Test system testing drivers for ROHM ICs bisected this commit to cause
>>>>>>>> BD71847 drivers probe to not be called.
>>>>>>> This driver (and overlay support) is in linux-next or something out of
>>>>>>> tree on top of linux-next?
>>>>>>>
>>>>>>> Rob
>>>>>> Yes the driver is in mainline linux: /drivers/mfd/rohm-bd718x7.c
>>>>> I don't see any support to apply overlays in that driver.
>>>> Ah. Sorry for the confusion peeps. I asked Kalle to report this without
>>>> proper consideration. 100% my bad.
>>>>
>>>> While the bd718x7 drive indeed is mainline (and tested), the actual
>>>> 'glue-code' doing the overlay is part of the downstream test
>>>> infrastructure. So yes, this is not a bug in upstream kernel - this
>>>> falls in the category of an upstream change causing downstream things to
>>>> break. So, feel free to say: "Go fix your code" :)
>>>>
>>>> Now that this is sorted, if someone is still interested in helping us to
>>>> get our upstream drivers tested - the downstream piece is just taking
>>>> the compiled device-tree overlay at runtime (via bin-attribute file),
>>>> and applying it using the of_overlay_fdt_apply(). The approach is
>>>> working for our testing purposes when the device is added to I2C/SPI
>>>> node which is already enabled. However, in case where we have the I2C
>>>> disabled, and enable it in the same overlay where we add the new device
>>>> - then the new device does not get probed.
>>>>
>>>> I would be really grateful if someone had a pointer for us.
>>> Seems to be fw_devlink related. I suppose if you turn it off it works?
>>> There's info about the dependencies in sysfs or maybe debugfs. I don't
>>> remember the details, but that should help to tell you why things
>>> aren't probing.
> 
> Rob reverted patches but I plan to continue my work on it.
> On my side, I need the reverted patches but I fully understand that, on
> your side, you need a working system.
> 
> In order to move forward and find a solution for my next iteration, can you
> send your overlay (dtso) used in your working and non working cases?
> 
> Best regards,
> Hervé

Hello Hervé,

I have attached the overlay source file: bd71847_overlay.dts

BR
Kalle

--------------RTMpC01dN2Tts0K0800P0dVv
Content-Type: audio/vnd.dts; name="bd71847_overlay.dts"
Content-Disposition: attachment; filename="bd71847_overlay.dts"
Content-Transfer-Encoding: base64

L2R0cy12MS87Ci9wbHVnaW4vOwoKL3sgLyogdGhpcyBpcyBvdXIgZGV2aWNlIHRyZWUgb3Zl
cmxheSByb290IG5vZGUgKi8KCgljb21wYXRpYmxlID0gInRpLGJlYWdsZWJvbmUiLCAidGks
YmVhZ2xlYm9uZS1ibGFjayI7CglwYXJ0LW51bWJlciA9ICJCQkItSTJDMSI7IC8vIHlvdSBj
YW4gY2hvb3NlIGFueSBuYW1lIGhlcmUgYnV0IGl0IHNob3VsZCBiZSBtZW1vcmFibGUKIAl2
ZXJzaW9uID0gIjAwQTAiOwoKCWZyYWdtZW50QDAgewoJCXRhcmdldCA9IDwmYW0zM3h4X3Bp
bm11eD47IC8vIHRoaXMgaXMgYSBsaW5rIHRvIGFuIGFscmVhZHkgZGVmaW5lZCBub2RlIGlu
IHRoZSBkZXZpY2UgdHJlZSwgc28gdGhhdCBub2RlIGlzIG92ZXJsYXllZCB3aXRoIG91ciBt
b2RpZmljYXRpb24KCgkJX19vdmVybGF5X18gewoJCQlpMmMxX3BpbnM6IHBpbm11eF9pMmMx
X3BpbnMgewoJCQkJcGluY3RybC1zaW5nbGUscGlucyA9IDwKICAgICAgICAgIAkJCTB4MTU4
IDB4NzIgLyogc3BpMF9kMS5pMmMxX3NkYSAqLyAKICAgICAgICAgIAkJCTB4MTVDIDB4NzIg
Lyogc3BpMF9jczAuaTJjMV9zZGwgKi8KICAgICAgICAJCQk+OwoJCQl9OwoJCX07Cgl9OwoJ
ZnJhZ21lbnRAMSB7CgkJdGFyZ2V0LXBhdGggPSAiLyI7CgkJX19vdmVybGF5X18gewoJCQkv
KiBleHRlcm5hbCBvc2NpbGxhdG9yICovCgkJCW9zYzogb3NjaWxsYXRvciB7CgkJCQljb21w
YXRpYmxlID0gImZpeGVkLWNsb2NrIjsKCQkJCSNjbG9jay1jZWxscyA9IDwxPjsKCQkJCWNs
b2NrLWZyZXF1ZW5jeSAgPSA8MzI3Njg+OwoJCQkJY2xvY2stb3V0cHV0LW5hbWVzID0gIm9z
YyI7CgkJCX07CgkJfTsKCX07CgoJZnJhZ21lbnRAMiB7CgkJdGFyZ2V0ID0gPCZpMmMxPjsK
CgkJX19vdmVybGF5X18gewoJCQlwaW5jdHJsLTAgPSA8JmkyYzFfcGlucz47CgkJCWNsb2Nr
LWZyZXF1ZW5jeSA9IDwxMDAwMDA+OwoJCQlzdGF0dXMgPSAib2theSI7CgoKCgkJCXBtaWM6
IHBtaWNANGIgeyAvKiB0aGUgInRlc3QiIGRlZmluZWQgYXMgY2hpbGQgb2YgdGhlIGkyYzEg
YnVzICovCgkJCQljb21wYXRpYmxlID0gInJvaG0sYmQ3MTg0NyI7CgkJCQlyZWcgPSA8MHg0
Yj47CgkJCQkvKiBMZXQncyB0cnkgdXNpbmcgR1BJTzFfMjkgYXMgaXJxIHBpbiAqLwoJCQkJ
aW50ZXJydXB0LXBhcmVudCA9IDwmZ3BpbzE+OwoJCQkJaW50ZXJydXB0cyA9IDwyOSA4PjsK
CQkJCWNsb2NrcyA9IDwmb3NjIDA+OwoJCQkJI2Nsb2NrLWNlbGxzID0gPDA+OwoJCQkJY2xv
Y2stb3V0cHV0LW5hbWVzID0gImJkNzE4NDctMzJrLW91dCI7CgkJCQkvKiAxNTAwIG1zIGNv
bGQgcmVzZXQgKi8KCQkJCXJvaG0scmVzZXQtZGVsYXkgPSA8MTUwMD47CgoJCQkJcmVndWxh
dG9ycyB7CgkJCQkJYnVjazE6IEJVQ0sxIHsKCQkJCQkJcmVndWxhdG9yLW5hbWUgPSAiYnVj
azEiOwoJCQkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw3MDAwMDA+OwoJCQkJCQly
ZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxMzAwMDAwPjsKCQkJCQkJLy9yZWd1bGF0b3It
Ym9vdC1vbjsKCQkJCQkJLy9yZWd1bGF0b3ItYWx3YXlzLW9uOwpyZWd1bGF0b3ItcmFtcC1k
ZWxheSA9IDwxMDAwMD47CgkJCQkJCXJlZ3VsYXRvci1vdi1wcm90ZWN0aW9uLW1pY3Jvdm9s
dCA9IDwxPjsKCQkJCQkJcmVndWxhdG9yLXV2LXByb3RlY3Rpb24tbWljcm92b2x0ID0gPDE+
OwoJCQkJCX07CgkJCQkJYnVjazI6IEJVQ0syIHsKCQkJCQkJcmVndWxhdG9yLW5hbWUgPSAi
YnVjazIiOwoJCQkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw3MDAwMDA+OwoJCQkJ
CQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxMzAwMDAwPjsKCQkJCQkJcmVndWxhdG9y
LWJvb3Qtb247CgkJCQkJCXJlZ3VsYXRvci1hbHdheXMtb247CnJlZ3VsYXRvci1yYW1wLWRl
bGF5ID0gPDUwMDA+OwoJCQkJCQlyZWd1bGF0b3Itb3YtcHJvdGVjdGlvbi1taWNyb3ZvbHQg
PSA8MT47CgkJCQkJCXJlZ3VsYXRvci11di1wcm90ZWN0aW9uLW1pY3Jvdm9sdCA9IDwxPjsK
CQkJCQl9OwoJCQkJCWJ1Y2szOiBCVUNLMyB7CgkJCQkJCXJlZ3VsYXRvci1uYW1lID0gImJ1
Y2szIjsKCQkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw1NTAwMDA+OwoJCQkJCQly
ZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxMzUwMDAwPjsKCQkJCQkJLy9yZWd1bGF0b3It
Ym9vdC1vbjsKCQkJCQkJcm9obSxuby1yZWd1bGF0b3ItZW5hYmxlLWNvbnRyb2w7CgkJCQkJ
CXJlZ3VsYXRvci1vdi1wcm90ZWN0aW9uLW1pY3Jvdm9sdCA9IDwxPjsKCQkJCQkJcmVndWxh
dG9yLXV2LXByb3RlY3Rpb24tbWljcm92b2x0ID0gPDE+OwoJCQkJCX07CgoJCQkJCUJVQ0s0
OiBCVUNLNCB7CgkJCQkJCXJlZ3VsYXRvci1uYW1lID0gImJ1Y2s0IjsKCQkJCQkJcmVndWxh
dG9yLW1pbi1taWNyb3ZvbHQgPSA8MjYwMDAwMD47CgkJCQkJCXJlZ3VsYXRvci1tYXgtbWlj
cm92b2x0ID0gPDMzMDAwMDA+OwoJCQkJCQlyZWd1bGF0b3ItYm9vdC1vbjsKCQkJCQkJcmVn
dWxhdG9yLW92LXByb3RlY3Rpb24tbWljcm92b2x0ID0gPDE+OwoJCQkJCQlyZWd1bGF0b3It
dXYtcHJvdGVjdGlvbi1taWNyb3ZvbHQgPSA8MT47CgkJCQkJfTsKCgkJCQkJYnVjazU6IEJV
Q0s1IHsKCQkJCQkJcmVndWxhdG9yLW5hbWUgPSAiYnVjazUiOwoJCQkJCQlyZWd1bGF0b3It
bWluLW1pY3Jvdm9sdCA9IDwxNjA1MDAwPjsKCQkJCQkJcmVndWxhdG9yLW1heC1taWNyb3Zv
bHQgPSA8MTk5NTAwMD47CgkJCQkJCXJlZ3VsYXRvci1ib290LW9uOwoJCQkJCQlyZWd1bGF0
b3Itb3YtcHJvdGVjdGlvbi1taWNyb3ZvbHQgPSA8MT47CgkJCQkJCXJlZ3VsYXRvci11di1w
cm90ZWN0aW9uLW1pY3Jvdm9sdCA9IDwxPjsKCQkJCQl9OwoJCQoJCQkJCWJ1Y2s2OiBCVUNL
NiB7CgkJCQkJCXJlZ3VsYXRvci1uYW1lID0gImJ1Y2s2IjsKCQkJCQkJcmVndWxhdG9yLW1p
bi1taWNyb3ZvbHQgPSA8ODAwMDAwPjsKCQkJCQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQg
PSA8MTQwMDAwMD47CgkJCQkJCXJlZ3VsYXRvci1vdi1wcm90ZWN0aW9uLW1pY3Jvdm9sdCA9
IDwxPjsKCQkJCQkJcmVndWxhdG9yLXV2LXByb3RlY3Rpb24tbWljcm92b2x0ID0gPDE+OwoJ
CQkJCX07CgkJCQovKiBMRE8xIGFuZCBMRE8yIGFyZSBlbmFibGVkIGJ5IEhXIHdoZW4gUE1J
QyB0dXJucyBmcm9tIFJFQURZIHRvIFNOVlMgc3RhdGUgKi8KCQkJCQlsZG8xOiBMRE8xIHsK
CQkJCQkJcmVndWxhdG9yLW5hbWUgPSAibGRvMSI7CgkJCQkJCXJlZ3VsYXRvci1taW4tbWlj
cm92b2x0ID0gPDE2MDAwMDA+OwoJCQkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwz
MzAwMDAwPjsKCQkJCQkJcmVndWxhdG9yLWJvb3Qtb247CgkJCQkJCS8vcmVndWxhdG9yLWFs
d2F5cy1vbjsKCQkJCQkJcmVndWxhdG9yLXV2LXByb3RlY3Rpb24tbWljcm92b2x0ID0gPDE+
OwoJCQkJCX07CgoJCQkJCWxkbzI6IExETzIgewoJCQkJCQlyZWd1bGF0b3ItbmFtZSA9ICJs
ZG8yIjsKCQkJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8ODAwMDAwPjsKCQkJCQkJ
cmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8OTAwMDAwPjsKCQkJCQkJcmVndWxhdG9yLWJv
b3Qtb247CgkJCQkJCS8vcmVndWxhdG9yLWFsd2F5cy1vbjsKCQkJCQkJcmVndWxhdG9yLXV2
LXByb3RlY3Rpb24tbWljcm92b2x0ID0gPDE+OwoJCQkJCX07CgoJCQkJCWxkbzM6IExETzMg
ewoJCQkJCQlyZWd1bGF0b3ItbmFtZSA9ICJsZG8zIjsKCQkJCQkJcmVndWxhdG9yLW1pbi1t
aWNyb3ZvbHQgPSA8MTgwMDAwMD47CgkJCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0g
PDMzMDAwMDA+OwoJCQkJCQlyZWd1bGF0b3ItdXYtcHJvdGVjdGlvbi1taWNyb3ZvbHQgPSA8
MT47CgkJCQkJfTsKCgkJCQkJbGRvNDogTERPNCB7CgkJCQkJCXJlZ3VsYXRvci1uYW1lID0g
ImxkbzQiOwoJCQkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw5MDAwMDA+OwoJCQkJ
CQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsKCQkJCQkJcmVndWxhdG9y
LXV2LXByb3RlY3Rpb24tbWljcm92b2x0ID0gPDE+OwoJCQkJCQkvL3JlZ3VsYXRvci1ib290
LW9uOwoJCQkJCX07CgoJCQkJCWxkbzU6IExETzUgewoJCQkJCQlyZWd1bGF0b3ItbmFtZSA9
ICJsZG81IjsKCQkJCQkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8ODAwMDAwPjsKCQkJ
CQkJcmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzMwMDAwMD47CgkJCQkJCXJvaG0sbm8t
cmVndWxhdG9yLWVuYWJsZS1jb250cm9sOwoJCQkJCQlyZWd1bGF0b3ItdXYtcHJvdGVjdGlv
bi1taWNyb3ZvbHQgPSA8MT47CgkJCQkJfTsKCgkJCQkJbGRvNjogTERPNiB7CgkJCQkJCXJl
Z3VsYXRvci1uYW1lID0gImxkbzYiOwoJCQkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9
IDw5MDAwMDA+OwoJCQkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsK
CQkJCQkJcmVndWxhdG9yLWJvb3Qtb247CgkJCQkJCS8qIFRoaXMgc2hvdWxkIGZhaWwgYXMg
TERPcyBkbyBub3Qgc3VwcG9ydCBPVlAgKi8KCQkJCQkJcmVndWxhdG9yLW92LXByb3RlY3Rp
b24tbWljcm92b2x0ID0gPDE+OwoJCQkJCQlyZWd1bGF0b3ItdXYtcHJvdGVjdGlvbi1taWNy
b3ZvbHQgPSA8MT47CgkJCQkJfTsKCQkJCX07CgkJCX07CgkJfTsKCX07CgoJZnJhZ21lbnRA
MyB7CgkJdGFyZ2V0LXBhdGggPSAiLyI7CgkJX19vdmVybGF5X18gewoJCQlpcnF0ZXN0OiBk
dW1teSB7CgkJCQljb21wYXRpYmxlID0gInJvaG0sY2xrdGVzdC1iZDcxODQ3IjsKLyoKCQkJ
CWNvbXBhdGlibGUgPSAicm9obSxmb28tYmQ3MTg0Ny1pcnEiOwoJCQkJaW50ZXJydXB0LXBh
cmVudCA9IDwmcG1pYz47CgkJCQlpbnRlcnJ1cHRzID0gPDA+LCA8MT4sIDwyPiwgPDM+LCA8
ND4sIDw1PiwgPDY+OwoJCQkJaW50ZXJydXB0LW5hbWVzID0gImlycS1idG4iLCAiaXJxLWJ0
bi1zIiwgImlycS1idG4tbCIsICJpcnEtc3dyc3QiLCAiaXJxLXdkb2ciLCAiaXJxLW9uIiwg
ImlycS1zdGIiOwoqLwoJCQkJY2xvY2tzID0gPCZwbWljPjsKCQkJCWNsb2NrLW5hbWVzID0g
ImZvby1pbiI7CgkJCX07CgkJfTsKCX07Cn07IC8qIHJvb3Qgbm9kZSBlbmQgKi8K

--------------RTMpC01dN2Tts0K0800P0dVv--

