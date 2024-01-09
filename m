Return-Path: <linux-pci+bounces-1923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E436A828404
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 11:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00661C20DCB
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 10:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DE2360A8;
	Tue,  9 Jan 2024 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="uVO74iKZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8AE35EE5;
	Tue,  9 Jan 2024 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704796160; x=1705400960; i=w_armin@gmx.de;
	bh=QipFuJnYN/Kb6LPSXeIwGxLbJpsBbnELZ8JaGfvIEdc=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=uVO74iKZ82uyXqOPSUH1IJLMn0Bvot5JQtF2vd5YzTpN06fYV4iex98TjLKGbm94
	 6XD+GmORYulBsOh/L9njMRc5k5F2+wzINoouGfiNPb693Uz6YQ3czAMxrDYmbBPsa
	 mNsYYH/xSpf2DCQD6GObYsSBg2/OBbnZKSMFipw62BymDGICcV9rM7ZbRXIyRcO/c
	 +UMbhDDV+/Yak/vn1lPPAnIf7keVtj4ICfykv4v9GnBCjRLCUtlB25TEwXRjbeWiO
	 vZnv7lue6czKqw0XXpa4hPzOo2CaoJS/dtk34NntzdN8GHxz877P1c5i12HiimtQw
	 lDRjM0q+yG/NrM/0Qw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJZO-1qjAFK2ZPC-00fQ5z; Tue, 09
 Jan 2024 11:29:20 +0100
Message-ID: <56911b37-c316-43b2-8dc9-10f6fd0a398d@gmx.de>
Date: Tue, 9 Jan 2024 11:29:19 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ERROR: Writing to dgpu_disable cause Input/Output error
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Athul Krishna <athul.krishna.kr@protonmail.com>,
 "corentin.chary@gmail.com" <corentin.chary@gmail.com>,
 "acpi4asus-user@lists.sourceforge.net"
 <acpi4asus-user@lists.sourceforge.net>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-pci@vger.kernel.org
References: <20240109000033.GA1986948@bhelgaas>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240109000033.GA1986948@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:eyFeimnROql3QynwpU6IC6doTX8iSSBI66lO4SDLrv4mrwp/7m2
 bgbvvBNx6FLx77xfhudKUz3HN4KIHc+BCOTTybTVNJSamfpvXLsKG52iWq5/luRO6kh75ev
 jgXNJY4Ly2MIRRd397DXnBDQJiX8qQ8bU5DPywy0VXAoTSpcDJsMVTjVTsouUOjtr29LLhY
 VNWDK9McDm95wGVqn279w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uURtABLTZvs=;be+4onCGJZFxcyteoHkeTl5+qeR
 Q0QXaUEFfFMDtwfcCWT+HvM6k8OplFiO+U5zGSHv0V3Eo4i1kc5FEZndTwIzWb7DYU7/fy3f7
 OeH/ldz3OsDk/qBrpMZAZ2UvO2Vcvu9GvtyE2Hl4Mm1g/RYaeSyBYlaZPJqqiekrx2qntoOMt
 es9DTzupBrhThji2SM3H23uGLGfG1GhWnyINKlz3Oqaoy9CwjhIuHuOJtzPQaEqt7LRweH9x5
 xQXFWmct8iCx8E474hydssj6gsszFWHjYGw6HEhqr4ck5i0p6IqIgY7IvY2dWudk43CYcEYNc
 uUByEuOKFtjiyqiVGMz+6nVlMt5ysvLwruBKCKac51xUG5nkucvX2CpTWghL25FFZ/L+nYAc9
 6702nNt3nQ9Z3LCzgE+g/YYj+p6APmPUcf75giuW5tl297KUhDpu4yO2RlB7tGa5yxlRVBWZG
 ARn/CXkzMHKkl6mBJakdY68qRUHR+uZ4M3v6y5bK78J8uCAoX5ZgNPxVUmbhD2bYVH/ENGI7C
 oWyuRAnNFSwD6XAgX/nkrs8tyMhDUF7AurPvGIApBZFkq5gaEA7aA2iHIWZAHF5cSO/dWwE8n
 yFzqjMoTKoeIgtXvvfz7sVTFHZ2kYwFWP4U83iNMoXBO+9ONEZyQJqY1yCLUV0xuZ/BD+Y4O2
 vTVu5TejKCyo42f29guB7ppn9RxTYErNNgie7HnfHln2pm2CoZIWr720LcmUWJhra0EznY/4S
 ZmWQ6S63S6nPVxzmc4nx5SZidjojwUM5EsYFVi4CSnEJJ09NfI8Pzp4yqyAwlrg+mjej+3cgL
 xlm7LvYYG5dI4Oy9elb2bmfflx5MDZH6DmFSfm9j6yGSI91ovJCJ3ZtI0V0pcE+kCKhJ00JN+
 6VM0NlQYTxX03PWIg/VcaNileA7GhjCSxCHjnntG3wDA5QfpIIr93jw5/t4KIvTfE95JiLJdX
 rmxjGnkSvqzPu2zVsZjabpI8LBk=

Am 09.01.24 um 01:00 schrieb Bjorn Helgaas:

> On Sat, Jan 06, 2024 at 11:33:35PM +0100, Armin Wolf wrote:
>> Am 04.01.24 um 03:50 schrieb Athul Krishna:
>>
>>>
>>>
>>>
>>> Sent with Proton Mail secure email.
>>>
>>> On Thursday, January 4th, 2024 at 1:05 AM, Armin Wolf <W_Armin@gmx.de> wrote:
>>>
>>>
>>>> Am 03.01.24 um 19:51 schrieb Athul Krishna:
>>>>
>>>>> Hello,
>>>>> This is my first time reporting an issue in the kernel.
>>>>>
>>>>> Device Details:
>>>>>
>>>>> * Asus Zephyrus G14 (||||||GA402RJ)
>>>>> * Latest BIOS
>>>>> * Arch_x86_64
>>>>> * Kernel: 6.6.9
>>>>> * Minimal install using archinstall
>>>>>
>>>>> ISSUE: Using /dgpu_disable /provided by _asus-nb-wmi _to disable and
>>>>> enable dedicated gpu,
>>>>> causes system crash and reboots, randomly.
>>>>> 9/10 times writing 0 to dgpu_disable will produce an Input/Output
>>>>> error, but the value will be changed to 0, half the time system will
>>>>> crash and reboot. While writing 1 to it doesn't produce an error, I
>>>>> have observed system crash twice just after that.
>>>>>
>>>>> Steps to Reproduce:
>>>>>
>>>>> * Remove dpgu: echo 1 | sudo tee ../remove (dgpu path)
>>>>> * echo 1 | sudo tee /sys/devices/platform/asus-nb-wmi/dgpu_disable
>>>>> * echo 0 | sudo tee /sys/devices/platform/asus-nb-wmi/dgpu_disable
>>>>>
>>>>> * echo 1 | sudo tee /sys/bus/pci/rescan
>>>>>
>>>>> After writing 0 to dgpu_disable, there's an entry in journal about an
>>>>> ACPI bug.
>>>>> Output of 'journalctl -p 3' and lspci is attached.
>>>> Hi,
>>>>
>>>> Can you share the output of "acpidump" and the content of "/sys/bus/wmi/devices/05901221-D566-11D1-B2F0-00A0C9062910[-X]/bmof"?
>>>> The bmof files contain a description of the WMI interfaces of your machine, which might be important for diagnosing the error.
>>>>
>>>> Thanks,
>>>> Armin Wolf
>>> Here's the output of 'acpidump > acpidump.out' and 'cat /sys/bus/wmi/devices/05901221-D566-11D1-B2F0-00A0C9062910[-X]/bmof'
>> Ok, it seems the ACPI code tries to access an object ("GC00") which does not exist.
>> This is the reason why disabling the dGPU fails with -EIO.
>>
>> I am unfortunately not that knowledgeable when it comes to PCI problems, i CCed the linux-pci mailing list in hope that
>> they can better help you in this regard.
> FWIW, I don't know enough about what's going on here to see a PCI
> connection.  I do see a bunch of PCI-related stuff around rfkill, but
> I don't think that's involved here.
>
> I think the path here is this, which doesn't seem to touch anything in
> PCI:
>
>    dgpu_disable_store
>      asus_wmi_set_devstate(ASUS_WMI_DEVID_DGPU, ..., &result)
>        asus_wmi_evaluate_method(ASUS_WMI_METHODID_DEVS, ...)
>          asus_wmi_evaluate_method3
>            wmi_evaluate_method(ASUS_WMI_MGMT_GUID, ...)
>      if (result > 1)
>        return -EIO
>
> But if I missed it, let me know and I'll be happy to take another
> look.
>
> Bjorn

The issue happens when a PCI bus rescan is done after writing to "dgpu_disable".
As a side note a bugzilla bugreport for this issue was recently created:

https://bugzilla.kernel.org/show_bug.cgi?id=218354

Thanks,
Armin Wolf


