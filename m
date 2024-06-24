Return-Path: <linux-pci+bounces-9199-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07399915306
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 17:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A96DB20AC6
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 15:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF8E19D09F;
	Mon, 24 Jun 2024 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wr45jnAD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41C714264C
	for <linux-pci@vger.kernel.org>; Mon, 24 Jun 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244740; cv=none; b=c9up9qae+p0FxwbgR4c49XoJyT77Nchn1PiOMy6/uOUPNTO2WBESj7OJAAA1ncHz/sY+kR6WwKu2IwDB+lyyh9xTdcrUjB6cWT3w5Qbyh2HxXpv9LEaMJpSd3ydAIXQEIj2Q7onbbIqRNKF5Qje2DOaF+QFX62yLWn2gi7+hRfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244740; c=relaxed/simple;
	bh=HLaR3hs5WDGPxxb4tgisddGf0k6b0fYRqtZE5Exc8so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9le1RSnJQt2lQISQNcz1kpZysu+wu37Qio231afP5/c/pHzbXrHxO0fYZP2dCkMQPOnBoQ+CbKNQh3AZX2ZGhGI7tWdv5GxEVl2KE5mTpXUxBnjRhDU+y5cTukftjoA3BvCr1opWteIZevPEHT4i/uqSL2nYaxZgaAAYE8YF/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wr45jnAD; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6fa11ac8695so2678320a34.3
        for <linux-pci@vger.kernel.org>; Mon, 24 Jun 2024 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719244738; x=1719849538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iepQcgESJWu6fglP8Amj/sOy24kSNXNSHSVbBlmACYI=;
        b=Wr45jnADKs/SrVoYj1EdUPiyLwoMiVuwEiV8ld5KUXXrMQ6GPoXUtnPm6TdAd2J0En
         W595R6QpqshfBnsIrAV92sJ8bkpLG9+XxqcKNatCrkNNbRHLHgj56XSo9SoXrwpS1tdM
         9Kwh0IzkV7KQV+DZCyT4jM4CZyr24MgWKip2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719244738; x=1719849538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iepQcgESJWu6fglP8Amj/sOy24kSNXNSHSVbBlmACYI=;
        b=JsSJbgQ+4zSSCF+opQa9eP/yEuUMUrjBJaG/crhqHalomjVv2F0FnSDQWUyRVoaS1T
         ki1hwkfSOww9IwkRQiU37G4kyFH0Q8NTG4XVH+KS6S4+vrt1vlWTcbvUHr6jVSfmaLSV
         ShWocQdEfq132geKPUVETxc+msh3r4WyiCigQdV1hxY0QmDwAgJwObRrpxThZFKfQS2h
         Dcc3BRLAiwDs3OdRKQ7H63gPhH23QOgaxe7B1gI3ybIDLYzvc/U4pyDZB2wVdCaBNk2b
         KPRrdu8XF9JtQ4ZrhYgFG5vvXORlgF5ZiamPJdYuR72bnK9oYpB9mPUKaqJIpbzNHJw+
         YVCw==
X-Forwarded-Encrypted: i=1; AJvYcCWpPz7zPfr3JNJbw6mxm4E02Wf1UarbseFCVRnmzI//tdXmj+XbZQMdopSGeQQbN7ZUhSspCelbXVhfH81oIHuUnp9dtWo3r6UK
X-Gm-Message-State: AOJu0YxHZEVeQ+4FbhJ3l0gDSs7woQm1RFeg3VRXO1LhVPkaj4WvGIRd
	e5b0VlwRbm8rVmVSA3GUn8WeLNAjqmWZXkxZcumKpN5lW/URp+Zl7a1bPxmzSI/nFHkPc8PW401
	4yo+M+l7YVF/Wu1a6SOqVjXTC9LY04qbl2UrJ
X-Google-Smtp-Source: AGHT+IEIyFPzR85NrmYtCNhaj5QOxe4OULcjrNN3pHSAFwPRzsRumq50hiGMtFKyh5aQ5z6TMgKo8aGXuIwQNaKLNEE=
X-Received: by 2002:a05:6870:2108:b0:254:bd24:de85 with SMTP id
 586e51a60fabf-25d06bd5436mr5767873fac.16.1719244737651; Mon, 24 Jun 2024
 08:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zi0VLrvUWH6P1_or@wunner.de> <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>
 <ZjsKPSgV39SF0gdX@wunner.de> <20240510052616.GC4162345@black.fi.intel.com>
 <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>
 <20240511043832.GD4162345@black.fi.intel.com> <20240511054323.GE4162345@black.fi.intel.com>
 <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>
 <ZkUcihZR_ZUUEsZp@wunner.de> <20240516083017.GA1421138@black.fi.intel.com> <20240516100315.GC1421138@black.fi.intel.com>
In-Reply-To: <20240516100315.GC1421138@black.fi.intel.com>
From: Esther Shimanovich <eshimanovich@chromium.org>
Date: Mon, 24 Jun 2024 11:58:46 -0400
Message-ID: <CA+Y6NJH8vEHVtpVd7QB0UHZd=OSgX1F-QAwoHByLDjjJqpj7MA@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>, Mario Limonciello <mario.limonciello@amd.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 5:16=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> I suggest trying on more devices just to be sure it covers all of them.

I tested Mika's on additional devices, Lenovo ThinkPad T490 (JHL6250),
Dell Latitude 7400 (JHL6340), Lenovo Thinkpad Carbon X1 Gen 7
(JHL6540) and the HP Elitebook 840 G6 (JHL7540) and the patch worked
smoothly on all of those devices. It looks good to me! If you have any
specific types of additional devices you'd want me to test this on,
then let me know!


On Wed, May 15, 2024 at 4:45=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> Could you add this to the command line:
>
>   thunderbolt.dyndbg ignore_loglevel log_buf_len=3D10M
>
> and this to your kernel config:
>
>   CONFIG_DYNAMIC_DEBUG=3Dy
>
> You should see "... is associated with ..." messages in dmesg.

I tried Lukas's patches again, after enabling the Thunderbolt driver
in the config and also verbose messages, so that I can see
"thunderbolt:" messages, but it still never reaches the
tb_pci_notifier_call function. I don't see "associated with" in any of
the logs. The config on the image I am testing does not have the
thunderbolt driver enabled by default, so this patch wouldn't help my
use case even if I did manage to get it to work. I did spend some time
on this -- it seems like it would take more time to test this out. And
I would like maybe an explanation on why it is worth it to look into
this, before I continue. I appreciate your patience with this!

Things I tried:
-searching through all existing logs for "associated with" and nothing came=
 up.
-I tried adding my own logs into the added function and compiling.
-I did cherry pick Lukas's commits onto an earlier version of the
kernel (5_15)--- I'm not sure if that could have affected anything.
-I tried littering pci.c with logs but none of them showed up after
deployment. I'm not sure at which point the thunderbolt driver decides
that PCI tunneling is occurring. That could be something to look into.
- I wonder if I am running into some additional ChromeOS-related
restrictions surrounding tunneling. This seems to be the likely case.

Also, this is what happens when I plug in an external thunderbolt
device. Maybe there's a reason in the logs why the
tb_pci_notifier_call function wasn't reached?:
```
2024-06-24T15:19:20.215183Z INFO kernel: [183837.056612] usb 1-5: new
high-speed USB device number 10 using xhci_hcd
2024-06-24T15:19:20.509844Z DEBUG kernel: [183837.349927] thunderbolt
0000:07:00.0: control channel starting...
2024-06-24T15:19:20.509867Z DEBUG kernel: [183837.349932] thunderbolt
0000:07:00.0: starting TX ring 0
2024-06-24T15:19:20.509870Z DEBUG kernel: [183837.349939] thunderbolt
0000:07:00.0: enabling interrupt at register 0x38200 bit 0 (0x0 ->
0x1)
2024-06-24T15:19:20.509872Z DEBUG kernel: [183837.349942] thunderbolt
0000:07:00.0: starting RX ring 0
2024-06-24T15:19:20.509876Z DEBUG kernel: [183837.349948] thunderbolt
0000:07:00.0: enabling interrupt at register 0x38200 bit 12 (0x1 ->
0x1001)
2024-06-24T15:19:21.879381Z DEBUG kernel: [183838.720640] thunderbolt
0000:07:00.0: current switch config:
2024-06-24T15:19:21.879389Z DEBUG kernel: [183838.720655] thunderbolt
0000:07:00.0:  Thunderbolt 3 Switch: 8086:15ef (Revision: 6, TB
Version: 16)
2024-06-24T15:19:21.879396Z DEBUG kernel: [183838.720667] thunderbolt
0000:07:00.0:   Max Port Number: 13
2024-06-24T15:19:21.879402Z DEBUG kernel: [183838.720674] thunderbolt
0000:07:00.0:   Config:
2024-06-24T15:19:21.879407Z DEBUG kernel: [183838.720679] thunderbolt
0000:07:00.0:    Upstream Port Number: 1 Depth: 1 Route String: 0x3
Enabled: 1, PlugEventsDelay: 254ms
2024-06-24T15:19:21.879414Z DEBUG kernel: [183838.720689] thunderbolt
0000:07:00.0:    unknown1: 0x0 unknown4: 0x0
2024-06-24T15:19:21.912146Z DEBUG kernel: [183838.753606] thunderbolt
0000:07:00.0: 3: reading drom (length: 0x80)
2024-06-24T15:19:22.511672Z DEBUG kernel: [183839.353220] thunderbolt
0000:07:00.0: 3: DROM version: 1
2024-06-24T15:19:22.517258Z DEBUG kernel: [183839.358696] thunderbolt
0000:07:00.0: 3: uid: 0x175942e1c49f800

[SOME VERSION OF THIS IS REPEATED FOR PORTS 1-13]
2024-06-24T15:19:22.523134Z DEBUG kernel: [183839.365301] thunderbolt
0000:07:00.0:  Port 1: 8086:15ef (Revision: 6, TB Version: 1, Type:
Port (0x1))
2024-06-24T15:19:22.523155Z DEBUG kernel: [183839.365304] thunderbolt
0000:07:00.0:   Max hop id (in/out): 19/19
2024-06-24T15:19:22.523158Z DEBUG kernel: [183839.365305] thunderbolt
0000:07:00.0:   Max counters: 16
2024-06-24T15:19:22.523159Z DEBUG kernel: [183839.365306] thunderbolt
0000:07:00.0:   NFC Credits: 0x7800048
2024-06-24T15:19:22.523160Z DEBUG kernel: [183839.365308] thunderbolt
0000:07:00.0:   Credits (total/control): 120/2

2024-06-24T15:19:22.531155Z INFO kernel: [183839.373585] thunderbolt
0-3: new device found, vendor=3D0x175 device=3D0x87f
2024-06-24T15:19:22.531156Z INFO kernel: [183839.373587] thunderbolt
0-3: SAMSUNG ELECTRONICS CO.,LTD F32TU87x
2024-06-24T15:19:22.535373Z DEBUG kernel: [183839.377053] thunderbolt
0-3: GPIO lookup for consumer wp
2024-06-24T15:19:22.535379Z DEBUG kernel: [183839.377056] thunderbolt
0-3: using lookup tables for GPIO lookup
2024-06-24T15:19:22.535381Z DEBUG kernel: [183839.377057] thunderbolt
0-3: No GPIO consumer wp found
2024-06-24T15:19:22.535383Z DEBUG kernel: [183839.377082] thunderbolt
0-3: GPIO lookup for consumer wp
2024-06-24T15:19:22.535389Z DEBUG kernel: [183839.377083] thunderbolt
0-3: using lookup tables for GPIO lookup
2024-06-24T15:19:22.535390Z DEBUG kernel: [183839.377084] thunderbolt
0-3: No GPIO consumer wp found
2024-06-24T15:19:22.538463Z INFO pciguard[782]: INFO pciguard:
[udev_monitor.cc(94)] UdevEvent: thunderbolt add
/sys/devices/pci0000:00/0000:00:1d.4/0000:05:00.0/0000:06:00.0/0000:07:00.0=
/domain0/0-0/0-3
2024-06-24T15:19:22.538474Z INFO pciguard[782]: INFO pciguard:
[event_handler.cc(28)] CurrentState=3DNO_USER_LOGGED_IN,
UserPermission=3D0, received event=3DNew-Thunderbolt-Dev

[SOME VERSION OF THIS SECTION IS REPEATED 7 TIMES]
2024-06-24T15:19:24.038230Z DEBUG kernel: [183840.880242] i915
0000:00:02.0: HDMI infoframe: Dynamic Range and Mastering, version 1,
length 26
2024-06-24T15:19:24.038271Z DEBUG kernel: [183840.880256] i915
0000:00:02.0: length: 26
2024-06-24T15:19:24.038277Z DEBUG kernel: [183840.880261] i915
0000:00:02.0: metadata type: 0
2024-06-24T15:19:24.038282Z DEBUG kernel: [183840.880266] i915
0000:00:02.0: eotf: 2
2024-06-24T15:19:24.038286Z DEBUG kernel: [183840.880270] i915
0000:00:02.0: x[0]: 35400
2024-06-24T15:19:24.038290Z DEBUG kernel: [183840.880275] i915
0000:00:02.0: y[0]: 14600
2024-06-24T15:19:24.038294Z DEBUG kernel: [183840.880279] i915
0000:00:02.0: x[1]: 8500
2024-06-24T15:19:24.038327Z DEBUG kernel: [183840.880283] i915
0000:00:02.0: y[1]: 39850
2024-06-24T15:19:24.038334Z DEBUG kernel: [183840.880287] i915
0000:00:02.0: x[2]: 6550
2024-06-24T15:19:24.038338Z DEBUG kernel: [183840.880290] i915
0000:00:02.0: y[2]: 2300
2024-06-24T15:19:24.038342Z DEBUG kernel: [183840.880294] i915
0000:00:02.0: white point x: 15635
2024-06-24T15:19:24.038346Z DEBUG kernel: [183840.880298] i915
0000:00:02.0: white point y: 16450
2024-06-24T15:19:24.038350Z DEBUG kernel: [183840.880302] i915
0000:00:02.0: max_display_mastering_luminance: 0
2024-06-24T15:19:24.038354Z DEBUG kernel: [183840.880307] i915
0000:00:02.0: min_display_mastering_luminance: 0
2024-06-24T15:19:24.038358Z DEBUG kernel: [183840.880310] i915
0000:00:02.0: max_cll: 0
2024-06-24T15:19:24.038362Z DEBUG kernel: [183840.880314] i915
0000:00:02.0: max_fall: 0


2024-06-24T15:19:40.375221Z DEBUG kernel: [183857.217231] thunderbolt
0000:07:00.0: stopping RX ring 0
2024-06-24T15:19:40.375267Z DEBUG kernel: [183857.217254] thunderbolt
0000:07:00.0: disabling interrupt at register 0x38200 bit 12 (0x1001
-> 0x1)
2024-06-24T15:19:40.375275Z DEBUG kernel: [183857.217286] thunderbolt
0000:07:00.0: stopping TX ring 0
2024-06-24T15:19:40.375280Z DEBUG kernel: [183857.217298] thunderbolt
0000:07:00.0: disabling interrupt at register 0x38200 bit 0 (0x1 ->
0x0)
2024-06-24T15:19:40.375323Z DEBUG kernel: [183857.217317] thunderbolt
0000:07:00.0: control channel stopped
```

I could share other thunderbolt logs if that helps!

