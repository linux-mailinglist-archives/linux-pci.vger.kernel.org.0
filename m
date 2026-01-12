Return-Path: <linux-pci+bounces-44539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 05515D14806
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 18:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8EA7E304754A
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745D937F0EE;
	Mon, 12 Jan 2026 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="lrtLPXs+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B93374176;
	Mon, 12 Jan 2026 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239712; cv=none; b=H/v/XtxOLtd+uW5q84YEoz5CEBCqod8rnh0G0/wBcfqWAeMabxmm5NVLhQavCfLBMqfXJhGl3xUr4TkDOvonoiqsJwp6Hgw1LW71M5q7bXoQ3JhL72gJCxH9R0jqOTggxnJY4e2hQ3CEy9A0MgBKykTfqMOw6oR/CRn50D0E5lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239712; c=relaxed/simple;
	bh=YXfG3cpftaBPyugNxucbUe1bRZTTS4lWl/EUAsvkqSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KUa6JuS7igrzbNFSXuOjGJO4FRFd95L1CMrb3DXpeV36flZwUA+/573kiyaoLQdCphOE87OXl3HZP0iooRa2tT1VyGahQBjUPJV2DfWU77Mhj+id1jBWJejogiYXepHjEH7kryE0X5TfS9zdtuKTM9/JUcWd20QzjUkxT+M40T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=lrtLPXs+; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1768239708; x=1768844508; i=w_armin@gmx.de;
	bh=5sNI0U4unbPia8BfWHfZSsP1d6huK3jxDWUqeEUG1M4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lrtLPXs+yhBhXsUzZThPYiyt4rTyAroZv8SIqvC843ZQTOZ+37VLpJ0WrNPraFjL
	 bpsafAVh5h0+Q6Ow6CrGNv5dOdwH1qE0uAuPZIDzK64xDYrELKJ+v0L24NgAj5wbq
	 GcXLOauqP6kUeiVyvK7Z9uegD15dX17A7Z0gnwS64TW/YpvQ0P/zwB7PeEgea9zcU
	 xp9KvoF6B51PQQPBoTS7E8AfSbgXcpGft6IbSZMKRwXjSl/Nh1RqXLYxI/7OfsCfv
	 10LZf7SHtlurtldT69trQTv+a560SOg6lHorjAd9q60hfycMtuef17tmAWuTx9621
	 Fw3XZcF/YX6oX8emrA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([93.202.247.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1wHAe02fGN-00amdC; Mon, 12
 Jan 2026 18:41:47 +0100
Message-ID: <1a107aaf-c1c1-46af-98a8-03eae1bb9db2@gmx.de>
Date: Mon, 12 Jan 2026 18:41:45 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hwmon: spd5118: Do not fail resume on temporary I2C
 errors
To: TINSAE TADESSE <tinsaetadesse2015@gmail.com>
Cc: linux@roeck-us.net, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org
References: <20260110172003.13969-1-tinsaetadesse2015@gmail.com>
 <d08f3edd-f5bd-4e6b-b174-e768d42df281@gmx.de>
 <CAJ12PfOP_ddk=nqaSDrravpgOYK3eTND24MaXo9RyzdN7cXLfA@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJ12PfOP_ddk=nqaSDrravpgOYK3eTND24MaXo9RyzdN7cXLfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:agqE3oTcENWS+X/7hVjyaGn6rBdBIc+MN6MZOM/qUONvWjAhQgo
 sFNmuPnqgH86fB9YPP8FoUi/zqJly0ArIVq9sxpbVXCWzvOijZgv6KpJUDrQOC0FM6/NwT5
 pkXk+h9Z+ZFDolVL7nFxWXCfE3T5AMVTINbYPri+k5ustMSaTmhiA1aw0VNLiUpXT1ALqtG
 pU1ZAZzKlhA1TZoWGyHTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6KhcLHkO3Mw=;hnJ7kLpzsrM6IxxoffMuL77y72p
 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

Am 12.01.26 um 12:48 schrieb TINSAE TADESSE:

> On Sun, Jan 11, 2026 at 1:27=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Am 10.01.26 um 18:19 schrieb Tinsae Tadesse:
>>
>>> SPD5118 DDR5 temperature sensors may be temporarily unavailable
>>> during s2idle resume. Ignore temporary -ENXIO and -EIO errors during r=
esume and allow
>>> register synchronization to be retried later.
>> Hi,
>>
>> do you know if the error is caused by the SPD5118 device itself or by t=
he underlying
>> i2c controller? Please also share the output of "acpidump" and the name=
 of the i2c
>> controller used to communicate with the SPD5118.
>>
>>> Signed-off-by: Tinsae Tadesse <tinsaetadesse2015@gmail.com>
>>> ---
>>>    drivers/hwmon/spd5118.c | 8 +++++++-
>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwmon/spd5118.c b/drivers/hwmon/spd5118.c
>>> index 5da44571b6a0..ec9f14f6e0df 100644
>>> --- a/drivers/hwmon/spd5118.c
>>> +++ b/drivers/hwmon/spd5118.c
>>> @@ -512,9 +512,15 @@ static int spd5118_resume(struct device *dev)
>>>    {
>>>        struct spd5118_data *data =3D dev_get_drvdata(dev);
>>>        struct regmap *regmap =3D data->regmap;
>>> +     int ret;
>>>
>>>        regcache_cache_only(regmap, false);
>>> -     return regcache_sync(regmap);
>>> +     ret =3D regcache_sync(regmap);
>>> +     if(ret =3D=3D -ENXIO || ret =3D=3D -EIO) {
>>> +             dev_warn(dev, "SPD hub not responding on resume (%d), de=
ferring init\n", ret);
>>> +             return 0;
>>> +     }
>> The specification says that the SPD5118 might take up to 10ms to initia=
lize its i2c interface
>> after power on. Can you test if simply waiting for 10ms before syncing =
the regcache solves this
>> issue?
>>
>> Thanks,
>> Armin Wolf
>>
>>> +     return ret;
>>>    }
>>>
>>>    static DEFINE_SIMPLE_DEV_PM_OPS(spd5118_pm_ops, spd5118_suspend, sp=
d5118_resume);
> Hi Armin,
>
>> Do you know if the error is caused by the SPD5118 device itself or by t=
he underlying i2c controller?
> The error appears to be caused by the underlying I2C controller and plat=
form
> power sequencing rather than by the SPD5118 device itself.
>
> The failure manifests as a temporary -ENXIO occurring only during s2idle
> resume. The SPD5118 temperature sensor works correctly before suspend an=
d
> after resume once the bus becomes available again. This indicates that t=
he
> driver=E2=80=99s resume callback may be invoked before the I2C controlle=
r or firmware
> has fully re-enabled access to the SPD hub.
>
>> Please also share the output of "acpidump" and the name of the i2c
> controller used to communicate with the SPD5118.
>
> I have attached the output of acpidump as requested.
> The SPD5118 is connected via I2C bus 14 and accessed through the Intel
> I801 SMBus controller (0000:00:1f.4), which is ACPI-managed.

Interesting, the ACPI code seems to do two things when the i2c controller =
suspends (aka is put into D3):

1. A unknown register 0x84 ("PMEC") is modified
2. The PCI BAR of the i2c controller is disabled

Since the PCI bar is not re-enabled during resume, i suspect that either t=
he firmware
is buggy or that the firmware relies on the operating system to restore an=
y BAR settings
when resuming.

I do not know how the PCI core handles suspend, so i CCed the associated m=
aintainers.

>> Can you test if simply waiting for 10ms before syncing the regcache sol=
ves this
> issue?
>
> I tested adding an explicit msleep(10) in spd5118_resume() before callin=
g
> regcache_sync(), for the I2C interface to become ready after power-on.
> With this delay in place, the resume failures (-ENXIO during regcache sy=
nc)
> no longer occur, and repeated suspend/resume cycles are completed succes=
sfully.
>
> However, relying on a fixed delay in the resume path is not robust and w=
ould
> not be suitable across platforms with different firmware and power seque=
ncing.
> It also still performs hardware I/O during PM resume.

In this case the 10 ms delay is OK since the specification of the SPD5118 =
device explicitly
states that the device needs those 10ms to become operational after loosin=
g power.

> Additional evidence comes from running sensors, where all the temperatur=
e
> limit and alarm attributes fail with =E2=80=9CCan=E2=80=99t read=E2=80=
=9D and temp1 reports N/A,
> after adding msleep(10). All hwmon attributes (temperature input,
> limits, and alarms) fail uniformly, which points to a bus-level access
> failure rather than an issue with specific SPD5118 registers.

Strange, what kind of error is reported then accessing those sysfs attribu=
tes? Can you still
access the nvmem part of the SPD5118 device?

Can you also check if accessing tempX_enable works? If yes then please try=
 to set this
attribute to "1" if it is still set to "0".

Additionally, please use "i2cdump" or "i2cdetect" to check if other i2c de=
vices on the same
bus are also affected by this.

> This supports deferring regcache synchronization and avoiding I2C transa=
ctions
> in the resume callback, since userspace may attempt to access hwmon
> attributes before the
> bus or device is ready.

As already stated by Guenter, the root cause might be the i2c controller i=
tself. Having
this deferred regcache sync only acts as a workaround, but we strongly pre=
fer having a
real solution.

Thanks,
Armin Wolf


