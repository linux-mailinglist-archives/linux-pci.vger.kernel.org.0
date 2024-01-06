Return-Path: <linux-pci+bounces-1740-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DC88261F1
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 23:33:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F142B1C20CCD
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jan 2024 22:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E4F63AE;
	Sat,  6 Jan 2024 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ikEn/iF7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B39101C6;
	Sat,  6 Jan 2024 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704580416; x=1705185216; i=w_armin@gmx.de;
	bh=GrQtBxb2aD7uqkKpMSnD+buQmfAffm95m12pWCOEg7g=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ikEn/iF7nkY/seeXnq0jXDt9LRAGdEKzR4WbDA2N+0EPIGFFqet3KdGvC+v0VHFR
	 1tlLv62kmgnb7qH9dyNx6nQfsMv8J//IhmKFAO5t53Qb2djRPMUvli2Nqe4AitrVy
	 7CCbrnaAZzVfns2QXET+NuXHbYnKzpTEn8lASTbeMICHyIxgpxrxCXhPzm+yTXEhk
	 HYnITNjfzrOf6b1L1433oA395AHdgAvUgxNaS7Dn4XTDPQW6uV1GWoSVC0TXOgnCU
	 mwEW9L/TMyLG/3FzTvA2+qHAPdpCIFVmaU5A3cw6Zmyo3lbxMfvnz9dvxlEadTodF
	 /xd/rGUGXLKEu8QEOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDysg-1rWArs1Ark-00A0sg; Sat, 06
 Jan 2024 23:33:36 +0100
Message-ID: <af094d61-eec0-456e-aeba-6e80c95424c5@gmx.de>
Date: Sat, 6 Jan 2024 23:33:35 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ERROR: Writing to dgpu_disable cause Input/Output error
Content-Language: en-US
To: Athul Krishna <athul.krishna.kr@protonmail.com>
Cc: "corentin.chary@gmail.com" <corentin.chary@gmail.com>,
 "acpi4asus-user@lists.sourceforge.net"
 <acpi4asus-user@lists.sourceforge.net>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-pci@vger.kernel.org
References: <GuvjyxvIK4bJrayfrvuGPORpcPhPT9WFxxtQ1nqeEyamn_po0WuVInoXQVRmpwBQkW9K0CCwDqSg6kXPEI9YTlU0LQ_FtIMmpxluOirycpw=@protonmail.com>
 <13fad62a-c82c-45b6-bd78-ad51232dbe14@gmx.de>
 <fXvoFRg43mZOs78mEX_CwN_2pi7KyVZkAIymCHa5i6DTyX-spNAHz6RDl31vrx_d1y-wrJhXEcUgPMHvmUwbDgYAXOgIOG_qdF3KCWTpJx8=@protonmail.com>
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <fXvoFRg43mZOs78mEX_CwN_2pi7KyVZkAIymCHa5i6DTyX-spNAHz6RDl31vrx_d1y-wrJhXEcUgPMHvmUwbDgYAXOgIOG_qdF3KCWTpJx8=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2j0YL5dsipavJ9qoIl4OfUM0nnu0CtlskQvZAaZWb0iWLtXyGR1
 UONm0mntrKxJSuMMNYz5OP2iMH8/uA2jjGNhDWFCid2RBkhuDr/bzlRkQYhBkSANw7I2/6W
 k4G2UJXiejr3Wj47g9l7XzJMziF0uLsv4XeJl2MmFT6d8eeHqt8AguDIFby7R2tDnq4BG/M
 ueRQmg8GmUgUvHJR9aqXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FZ7cmxRv3d8=;9H7H/UYKhU/lBoXmUWeDVCYKc4m
 i8zL/jyVZrQVZnDAHivzwiBh1Vs7y3K7GpE/dsbJtuzIRoz3jTYOS1Cgbc1CuPWslyZpDmnlJ
 fQB9gZojfz2j/txyz58c1xb2kLCTPB4UaApsyaEur01gvVV1UOnBT7nL0D7CNSCEn4D8vneAQ
 jMF9UOfNPR6/wrowpmm0DLna2qtLZo5OW0a2teHsB08LkRtbU7c7WyvTUj64DW3qoPWT371EK
 lfrx0R9HnpEnmLcXYCwSgzXCGUZIXS3WjVduiv2zAaznwNhh8o9PoCs1dlA8d8FUpnddk+aUl
 dhjeCUmx96XtB1M9aZImPKAyuytxMf59vI1a9ksiEJ35dnJHBaV9yEEUuNg8dDuWiRm/KxkJI
 0dScgOqCU4DSA0DwQrBkxVt0BdN6u3qxXAVltAaCSUWan8eclaSFSariJswPCKzH0xUEqpLlx
 duCjAhh6QrZIdVFIiXRVkDsXx0zleH2uFM7MAbVo6Pwui+SrPgNTa/9S0RTlWwsxqxhsizzsv
 OMOk82xG/X2zOJXNR0mwgwcc2wSlHYo7yjZV46bHAzL64ocwbOVXamVQYod67h6avXN6h0dkS
 j9CeBz3egiBPwFUvMwEMdmwd7YEEqI9ciL2xp772J3mGHzJOl3oQtGjd6AZ20CRb8VxUu4LnS
 XNypYHmKdLRh6S2PevPg6fg6V1xDFhf7fZkhwT6WinNSdf4+HuvB5QjVLXTRmy0ULsSFkgCcj
 NKYAWVvBRKSvsDD9PGbJRZ+MN499JtWGTHeoRhiAJZkdETVFJFIdJ70soCtuRl/MQJRhk9dVU
 HLpaKvc2zON/VsyvhCA3mQ8vqH4lOplqrCDV1nz59OqUyrcdrroK1wpcPjO9ZZCI3lSaAUBBZ
 5S9CHHt/31pCm5cXB8ggbZE8V3lawD6gojW1ZFlGmUTxZlfb42kSXsbVq/tt7SOU+hrdymJ9f
 0nplo8+hK8xqvbh14kf4xRir2KY=

Am 04.01.24 um 03:50 schrieb Athul Krishna:

>
>
>
>
> Sent with Proton Mail secure email.
>
> On Thursday, January 4th, 2024 at 1:05 AM, Armin Wolf <W_Armin@gmx.de> wrote:
>
>
>> Am 03.01.24 um 19:51 schrieb Athul Krishna:
>>
>>> Hello,
>>> This is my first time reporting an issue in the kernel.
>>>
>>> Device Details:
>>>
>>> * Asus Zephyrus G14 (||||||GA402RJ)
>>> * Latest BIOS
>>> * Arch_x86_64
>>> * Kernel: 6.6.9
>>> * Minimal install using archinstall
>>>
>>> ISSUE: Using /dgpu_disable /provided by _asus-nb-wmi _to disable and
>>> enable dedicated gpu,
>>> causes system crash and reboots, randomly.
>>> 9/10 times writing 0 to dgpu_disable will produce an Input/Output
>>> error, but the value will be changed to 0, half the time system will
>>> crash and reboot. While writing 1 to it doesn't produce an error, I
>>> have observed system crash twice just after that.
>>>
>>> Steps to Reproduce:
>>>
>>> * Remove dpgu: echo 1 | sudo tee ../remove (dgpu path)
>>> * echo 1 | sudo tee /sys/devices/platform/asus-nb-wmi/dgpu_disable
>>> * echo 0 | sudo tee /sys/devices/platform/asus-nb-wmi/dgpu_disable
>>>
>>> * echo 1 | sudo tee /sys/bus/pci/rescan
>>>
>>> After writing 0 to dgpu_disable, there's an entry in journal about an
>>> ACPI bug.
>>> Output of 'journalctl -p 3' and lspci is attached.
>>
>> Hi,
>>
>> Can you share the output of "acpidump" and the content of "/sys/bus/wmi/devices/05901221-D566-11D1-B2F0-00A0C9062910[-X]/bmof"?
>> The bmof files contain a description of the WMI interfaces of your machine, which might be important for diagnosing the error.
>>
>> Thanks,
>> Armin Wolf
> Here's the output of 'acpidump > acpidump.out' and 'cat /sys/bus/wmi/devices/05901221-D566-11D1-B2F0-00A0C9062910[-X]/bmof'

Ok, it seems the ACPI code tries to access an object ("GC00") which does not exist.
This is the reason why disabling the dGPU fails with -EIO.

I am unfortunately not that knowledgeable when it comes to PCI problems, i CCed the linux-pci mailing list in hope that
they can better help you in this regard.

Maybe you can open a bug report on bugzilla.kernel.org so that things like ACPI table dumps, etc can be collected there?

Thanks,
Armin Wolf


