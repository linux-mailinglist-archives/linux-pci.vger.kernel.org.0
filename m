Return-Path: <linux-pci+bounces-1534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FC381FD1F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 06:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37460B22407
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 05:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCE41FB8;
	Fri, 29 Dec 2023 05:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=crc.id.au header.i=@crc.id.au header.b="grMlhT3f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailfilter.crc.id.au (mailfilter.crc.id.au [202.172.99.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4220FC;
	Fri, 29 Dec 2023 05:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crc.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crc.id.au
Received: from mailfilter.crc.id.au (localhost.localdomain [127.0.0.1])
	by mailfilter.crc.id.au (Proxmox) with ESMTP id F284961599;
	Fri, 29 Dec 2023 16:46:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crc.id.au; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=default; bh=EzA4I9oxv9twX0fBT
	4dYB1xTAfs78hsRJSgPdiv8UCk=; b=grMlhT3f661h6Zp+vD+aVcxCIptPyx8yO
	dXrUj+WazhWR7H0AUNb7j9/bz32uWpmb4xOOBhkPKZm7G8XAkzVmbSW4mt4WsECQ
	+Q68jD4biXEvjWBKqXYcCPBB7UI73r+Oy0EZsZdOu1tk2wd2M+3rlBqCv89hLg/u
	YhuuTbMPnK5y3rxbRLAefJ3y6irXywJdG5vHh/I8wuYw+Zf6m+FFnu9OMtWSWK7K
	d0sLM4joAbfX6+exWIDn1SqJu8bB6Oi85S0nfJt9GRJZJfHohQqN8dY1wd8ADDqC
	5BgD4zYgoznRYlB3i0L5R54BMzSXAG9Fv6Ow55SzfbyMbCAYEBe/TO+/gb7ZAfgy
	QzttvtI5lT+plN3k6FLcCQW1trGqt5adnBUk78VG05yWggHmm7sIC0xh0T2TADl4
	ddSL9VBuFUmUud3fDf+6DYiymmINgDa4cuZOkeGBocQ8sIOIlAizng15yqcU56mI
	MsbmQMV2cheg3eCdDgdKDgWPGW0j1ySUkqTsoyBEoJnzKRJ6nNZQfUcxTUZeDxH4
	7vXHs2wfakh0YO649G7o0hOtrUSAwge+nTfz9WrUpgGndpji8C2yymF5JTBB3rEN
	IKEOuO1sRdarM1ijGK4NCLmxm3mgTFgq3Hc64cYCjHo3srpdE8ZaNH0rtN0lkFSE
	iJmXbwfELY=
Message-ID: <5f4dfc03-bdfc-41d1-8c5a-1e767e472a96@crc.id.au>
Date: Fri, 29 Dec 2023 16:46:50 +1100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Qemu KVM thread spins at 100% CPU usage on scsi hot-unplug
 (kernel 6.6.8 guest)
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 f.ebner@proxmox.com
References: <3a7656ab-df4c-4d57-8866-661beffcddd7@crc.id.au>
 <20231228131802.GA21994@wunner.de>
Content-Language: en-AU
From: Steven Haigh <netwiz@crc.id.au>
Autocrypt: addr=netwiz@crc.id.au; keydata=
 xjMEZYuvwhYJKwYBBAHaRw8BAQdAKpahulREd3FFQb6QJI7Oa1QG7i0y5GxpKWd/Pgz3bDHN
 H1N0ZXZlbiBIYWlnaCA8bmV0d2l6QGNyYy5pZC5hdT7CiQQTFggAMRYhBIB4i95REtt8lf8r
 5YPV5iDbUrwABQJli6/CAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQg9XmINtSvADhuAEAq5fb
 ocNh/FVsflYj8owAQlb3jez8GcMdZqBty8OAY2QBAK+xbsxaJ+KtOPFmmmzzLcf5LQFvOYZs
 o+Y3Ot5ublIIzjgEZYuvwhIKKwYBBAGXVQEFAQEHQH0ZpXIkJEoTdAhHcvEj417Bb55+wGsz
 07FgcbLaIl9AAwEIB8J4BBgWCAAgFiEEgHiL3lES23yV/yvlg9XmINtSvAAFAmWLr8ICGwwA
 CgkQg9XmINtSvABslgD8D7f1NX9bEu5mH8VF7Z58Orygx4Qc7w5qvM1qvQB8UfkBAID3m4bI
 0Y9hW5iuV4RfgH3SkrIp4diWii1facZPd4EC
In-Reply-To: <20231228131802.GA21994@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/12/23 00:18, Lukas Wunner wrote:
> On Thu, Dec 28, 2023 at 01:03:10PM +1100, Steven Haigh wrote:
>> At some point in kernel 6.6.x, SCSI hotplug in qemu VMs broke. This was
>> mostly fixed in the following commit to release 6.6.8:
>> 	commit 5cc8d88a1b94b900fd74abda744c29ff5845430b
>> 	Author: Bjorn Helgaas <bhelgaas@google.com>
>> 	Date:   Thu Dec 14 09:08:56 2023 -0600
>> 	Revert "PCI: acpiphp: Reassign resources on bridge if necessary"
>>
>> After this commit, the SCSI block device is hotplugged correctly, and a device node as /dev/sdX appears within the qemu VM.
>>
>> New problem:
>>
>> When the same SCSI block device is hot-unplugged, the QEMU KVM process will
>> spin at 100% CPU usage. The guest shows no CPU being used via top, but the
>> host will continue to spin in the KVM thread until the VM is rebooted.
> 
> Find out the PID of the qemu process on the host, then cat /proc/$PID/stack
> to see where the CPU time is spent.

Thanks for the tip - I'll certainly do that.

Annoyingly, since I posted this report originally, then adding in a new report to the kernel.org lists in this, I have 
been unable to reproduce this problem. I have successfully done ~22 scsi hotplug / remove cycles and none resulted in 
reproducing the issue.

Kernel versions are still the same on both proxmox host and the Fedora guest - however I see an update on the host of 
the qemu-kvm packages in Proxmox. The proxmox host hasn't even been rebooted in this time.

I wonder if the initial revert included in 6.6.8 fixed the main problem, and the later update to qemu-kvm packages on 
the proxmox host followed by the last reboot of the VM with the new KVM package sorted the second issue.

Seeing as I can no longer reproduce this reliably - whereas it was 100% reproducible prior, maybe I'm now chasing ghosts.

I'll still continue to monitor - as I normally do this SCSI hotplug ~3 times per week doing backups to different 
external HDDs - so if I do observe it again, I'll grab the stack and reply to this thread again with what I can find.

Until then, I don't want to waste other peoples time also chasing ghosts :)

-- 
Steven Haigh

📧 netwiz@crc.id.au
💻 https://crc.id.au


