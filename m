Return-Path: <linux-pci+bounces-45067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 56557D3395C
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 17:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 636FC3008DC3
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 16:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6B9399A70;
	Fri, 16 Jan 2026 16:53:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF0426E165;
	Fri, 16 Jan 2026 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582402; cv=none; b=Z/eMyzwc0wZ2VRDULGO6cq0hn0ku4cxJVHfo3jRNcocCTZhRRYl4488wGClWJeL5Pv820A6Q1UOjTb9hVU+PGGJX/RJnjSdLzYPUuanRVrq2NDXsa6q5BiCA2CzihYPzX6UFspFTO0mf46MTNCkug1p72r0+3yVqs7gKTof2ZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582402; c=relaxed/simple;
	bh=UyWcqJuYG7erDENHB5r9nkOQkPHE2vAVOPfOxc5lhYE=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:References:Subject:
	 In-Reply-To:Content-Type; b=LwYG80DQsxELIajY6/AP8bnFvMX7XG9S2e+3ROJIUN60XUQxXsOx4CK4vg/Lwui8+EzEP2ZfL7xtqRL3ZJ4FmNvF3kCXgXpVYZMSvScnhdtBQETqb0FtQIQez4d3JtU8z97b2fx/iA2FTNnrYJ1wmAbZhQ7JJYjfdNPCXuulKUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.126.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from [192.168.0.66] ([88.171.60.104]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MZkd5-1vLWt82rqR-00XAh9; Fri, 16 Jan 2026 17:52:37 +0100
Message-ID: <3780eb61-68e2-42ce-939e-7458cd3a63cb@green-communications.fr>
Date: Fri, 16 Jan 2026 17:52:36 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rob Herring (Arm)"
 <robh@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Joerg Roedel <jroedel@suse.de>, regressions@lists.linux.dev
References: <a1d926f0-4cb5-4877-a4df-617902648d80@green-communications.fr>
 <eb94b379-6e0b-4beb-aaa7-413a4e7f04b9@green-communications.fr>
Content-Language: en-US
Autocrypt: addr=Nicolas.Cavallari@green-communications.fr; keydata=
 xsFNBFKGRC0BEAC+nMoqcTXudlSZXH9EwSbOQuiIXTAxeVSX7WXxUvH5gqBamTSgBN+G7rvD
 UtTCSAbKkTG01rBZbbhwRl2vM0oi8Hg5sOvJ6OskKzIU4MWMzi0qNaKk2RPSE2wI7xo4N/M4
 aiJcmqhmzwLrr4FvuvTNDC+mX43/uFFQeWs4DiIRhwthO7WQmzvmmpwZIGBQxgfaveEZgzVR
 HMVVMTS1tlJntMgeb1JgYWMDUbZTRbigegrM08hrG5deK08uD9djGI9Mdu9WR1S4PCVXMVqI
 WROX4AQTCl9pgQEtnxnYeB4VvA9iInYpsg9gSR6QhZxluK0A4OFQF2HfqIwT0Z4K4xFl+9v/
 EcZRK3d5Lry9GEinFCf2H6tRDFRxxK3m3/D2UAR601Y/buIK0sCMNwcpc5yYHmBSyAxM2j2s
 29gEnhDMQbLn93cHSERaRk3lExJM7vtTxBMSPm+7DrOmIF358IHQXqrY1xYl4eBG+R2aGS30
 pH5cGycCL+VxWg8K9pSF5w4XT+XvRsaAmkvQ1GApkTjOhjDDXzWxX5w1DMKW8io3GM28lf8z
 mE156/FOlG6SQBHZZjJ22+5TiZRKO5HK+bJav8L/NeqavmZ9evNLVpr1BYiG1Ph769laSpbi
 Zt3Dar8hc+IQvR9ig7tWPbSmha95gMJP35Kwy45M+u97hAZOBwARAQABzUROaWNvbGFzIENh
 dmFsbGFyaSAobWFpbCkgPG5pY29sYXMuY2F2YWxsYXJpQGdyZWVuLWNvbW11bmljYXRpb25z
 LmZyPsLBlQQTAQgAPwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQTEcT9CxhYiex4F
 Htv4pX245AdyAgUCZvF3TwUJHdE0ogAKCRD4pX245AdyAlq5D/9+BfuYe3tXms6xJyxBe7PJ
 guDeQL5p5a/kTT3cwesRt61sA8t+iRAVuEH5kBREAPbcX7iXMtqQ5OXfWSD6pk5uBSi/vnj6
 kAlbReP9qYBq70XecEccqXP/N4MBsV8nulmyWyx37ARkqOgRPPgyCQkijpV8oHA+SMxHDyYi
 WGoOY5HdztaLCU5rpTe4+izjmLcyzPiAfNowv9DSVwU8TRsqIRoxzm4sxkU1Pe3AN0OuTiH7
 aIjirRpaXbD56YtF9ExPEoEpUvAWkWCcnCstTovqh0LasALc7l3prG+88n0nKf2yRh5rfBhm
 tQHGBiZiLholIiv4PJi9K4hM8nvzSjJnBhQwLQsedzjeXse7h0vSZGNYB9mJN1fuYOOZI7Go
 PdHddyuARe/zezU5h+tz7l6glaHpOztiHPaCgWldRpH/JqIrvDVZjBj9u719+N7J21K5BFDA
 h0PSoEjMuQU8pQJmjTuzJZzYv6Nyp/a+p6I4i4UWRNpM+B8wVl8G0HcHur7SO5MOG+YBtz3N
 MqZUZjTjoeLCJM4A48EvUiTI6igyN6KcAINjbO1eLgaBEJO9j5CLNS/n6krHxd97rRC0KB4L
 ZVghxYw9xcBNOwkLW6LmIDwuTzB8J+X3K5IKRPIPffNLHLh340A5U1Oj5jilvoaCO8rn7RVU
 /FlfmP6l6WH1T87BTQRShkQtARAAsdhjcnSDMT+Y0m9MnQ13dAe8TLW/79f7SjDN0V5L/oxM
 EhlTX9/1Qc9iTUv6ZCVwo9xK6EPvB7jXEHdwyW2Lc5PNgAYPIhIPpPemC1+HuZDQxjpHAELD
 8uMann0Jgogl9lyYPGDkWa9L0Aurd9AuCeMBX8MIiBMxKhwHrhnpU2T/DaPBwP0EcKrXd/Gr
 TNcS/C55odNsqBQ4/vYdJAVz25byMlppMAxEendO2oiUump3oyvpk9BmHBWTIGyA2xsIQKu/
 +sm12m16FqH8ppMw27te1dlMTaa+akmi59l/XFPgdARQ3UNXbNLm+pf86POtVdGhVrX8KfDJ
 r2H17IpS7jC++pp4TAagfEeaqtD5erHrRHg8UqxDYnRxB8gJbqTgFQu1MxHYyNodeDw1oJG6
 wGd0XEVswCPr1Fmeht/QRNJ1wZzB6i8/oo5X/TgYJiMGFYTPz5t6aWFp7yJZHBzLuE1JcMlN
 bcdFn60QSGI5R9RgCqcHXtxxvUXjYLIuelQl+OdPmV49Wjzknu0l9Uw3CmRGlG6vQKlWOsUz
 z32o3x+zPkLw+ciz6tNEQ6s45MUmGl2Fr+OOaYD4jc8PlRTvqj0IwVnXwCIQ28sh4FbJwsoU
 xrcINmEmYCpSIZEKR2Y7YnlVmW4fb3b3xez3pjb/jDBNDt5Dw4IFwcqT8zpIkXcAEQEAAcLB
 fAQYAQgAJgIbDBYhBMRxP0LGFiJ7HgUe2/ilfbjkB3ICBQJm8Xc4BQkd0TSLAAoJEPilfbjk
 B3ICue8P/0mjR9Hyx2MPhyNhRRsCeFpqZMUSPeBh7o8+2MShWIHLt1XurDJod4oJqIEoFZYQ
 9zzGD23up5oS84WQCb5G0EXy7tdpLLKImrKqa8xt1sLj0popUCH+A2w7B/kAOyU4HbNE2ZBx
 jX3ir1ecFIqskaOegl4ulv7As1hCvp1JxbCehgAnKphHV6yast16lhfvwt3TKUA0WmtzrA5F
 mqnIxNSQY5gWxIfGmXXceQelZ6MhZm/SYFQyDrBh+XmIhNrg3r4/rKaLSeDbeJks2Dd7ArnD
 T5n4gq87tOHQBS15Riw7uqfkUPuzkGrf6wI/L1SitHgqFkQ1fXq+fU6OwckaTvgVe82+s5oL
 xnMEywFi1zReL/r50afTnz0YWNGJ+svUGeu8/sl7Zgh++NDHpTQCqe0Xu6Q+6H9SRiSmyS1G
 sZhjWwFjk6s/RjmPhZcJ0LCYSKRSYXMgg8Pm6Z/woLFWQRt/4wc3ZvzI2zTgBgEyeu+o86cZ
 KTFSx1sD0GSkFa+SRcOMdr5L/qQ8vuFeV7LYOUFw1LIPEToJtv+K6RdTQ7avzLBWZOrmqE2r
 RppToNOj/ihnpeDsnAmdJG3/8TInGXPgWP8cEJ892///fl4Ejm1KePuro3M0qENUtY5Z6LSt
 XMjIkcCihY9vSksnm5C7d6wGxy2/Mju8s0J1tRaXkjbj
Subject: [REGRESSION] Re: imx8 PCI regression since "iommu: Get DT/ACPI
 parsing into the proper probe path"
In-Reply-To: <eb94b379-6e0b-4beb-aaa7-413a4e7f04b9@green-communications.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:0DXwg001tGdJx+6nnHcKaJyY+JXUE76/+mrrZAHUZQSqGKa6+jJ
 cSEAOsBjFeGwDRTK/stEgatR6jQlyLl1W54MyKc92sT0NWPNwvxRKHmZ+UKppd1VkWXJ4I4
 VWphKzDPqTTfzqQ7OzdJOBH+5lMGJ6eXiQRf7/PBgGS22nZe9rene7tLWhuAbhDlUbkt1Rv
 hNs1kj0v+zzW/phZPurzw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JoRGtJ0IDf0=;lx6MiK6jrsDqYft46gHh7IaEOfm
 zkQB7eFqkoabHW1mICr9z1Yu1zxCjzMMVPmILHPoPTPlnNn9Goagj5TrA2h/1V5pk42Ks/Ud4
 d5RSCW2PFnMmLDchE9rUZ5d/iKRcX99ap1qKUShsJy1Ywq+zY36B9Thuwhxwup0BAQsAVfGDk
 Hb2H9kV9PJaDyAwufqX+r0jCmfQsDTM6ZJvPZrUbxWLbThwWqrDD/UzolxO8z1eWcCGYC43E/
 qKnkj36ZnYcQW3jiy8c5y79X6UKjCpKFFRJ8KSKLAVixNRSZEdQBoUht/j13JwOH01FrDWQ/V
 CCo1hJG+g7EWVDTa3JNKATNUYfYgLjoSyE1lfe8djHUC1iUjeL9N5i4kDkJMxo59g7ExGbqPv
 0f09hCe3DdnaloeQpXYYEgkoEKzkXRsEbls2ltM8Amntf5cmMqTU76ZdirslIBKH13kvLUt+r
 FL6DcEmczMdQMMrauK/otsMEMr7RVJOwAiWN9TVbbjFH2xtVTn7fyCuGdDXTdco8mlXN8fbiP
 Bm4kOFFkBRIYgIDzQtR6zShkTUQAZfgqN+WfZQ6Ran2XvykMUlp/EeVMP1ye/GO1BbmRwZqh9
 oMOrnvBJmRI+e/QEbedJ567Vj60iw6TgmBp+myZpDQdjcV8u7iWOB/IJc6QwrLAVC8y5SddaK
 mwNo6gfyS8Ww6UKaWtF1OVB1dB9NT8H5TnfCi/0IibzL1ulGuEuBr5pPqemZ/cYSQzQGi/cMY
 j6ThPnO6WBd2I9FylOlGkcIPIZN0Um3XYP1Xb2c3cJxrivbdzecU/y8upmb+fjpg+1fZl6MXc
 sIfeG3KkIJyS8v2vuIQ12l2/uqs1RIQ+gHBMKrLe3RDtOzEbo1y1YzWEL680JUyxYlK5DGo6R
 pCK6JQVtIOSBKNZ16vb9iBhxKLqO/zK74561gkgdHOKdBuh6027YRjJEcfKdCL2VUdpmkUCGO
 tBPHYI4Q7aKWuD+W0fPLck3Jnc8cX5Wo51j6gOAHqdZJNRXETnrM6DrTybjLkp24P35EuXAfL
 zqxwOwxG3/HpM8WYRGOqcWYAPm4bHXupvuvLDKVe0wD2W+v0gP2B/6irgx+9eTaEEEwt1snek
 IR6/yhuDdu6FYsd8rHOIIS3AXKZ+HJ0y5TJz/w7Tip55EusQiRoWf3loefMdeshTPv+4bO0BS
 tnWJbo+BpZxje9vu6g+XF1NTxMsWVdjaqPlzUvo9gGIAk6vGNuc20HTcb9++KvddkPeix3ITW
 umNOEs22xGVAEZxvhsXZGBxzIlurPSwFiLQKEeSZWZUYP3YD6gnm8KWCMDPVBDHjfitC70zsz
 e+vDFMsCvnXPVIxcmmNVJsF4677pQrxxgFnr04W1QuUQxylh7rZ6XojRQ2/heEYpcSN9ehRDZ
 Y3o11eOgc/64B9aemnGGpcJE6a0pELAbN8qhkMPBGHGlcytYZBEoEXeqJwAh74DpDrWiM1TOI
 vtQLC7j7kgDTS5Rb9bdyyb2R2AzUFIqoVfHjICtCKwE17fWSdaDB8sfWiZBlh5X4RssdAlACE
 cjOdKw+BWDHEsRY54Z2RTw7mAcnZ4lKb5xGs6rajWUtgcGKbNK7m/T1Qy0XIKUTyDoGpx5Jit
 hk+1i0q/kiI+6erX31zwPGu3EU9iC0tgg5H0r22kP2NYvAbCqKeavYNMn1v2faM4Evrlxx/n9
 1R8sCHAMZJFb+q5YdjWlvFA5hJ2GM/cEdFkk2C+3jcvEMdeFQc8jP6owK0Daq8SG0aNekACyX
 +2NfXprvWL4DIr5YX/+aQXgIWCCoXIdBxMU+adGfYr+a/mbAovmapl5c=

+cc regressions ML

Le 13/01/2026 à 10:17, Nicolas Cavallari a écrit :
> +cc patch author & reviewers
> 
> On 1/9/26 17:22, Nicolas Cavallari wrote:
>> When upgrading from 6.12 to a 6.18 kernel, I noticed that a PCI
>> Ethernet adapter (Microchip LAN7430) would hang under load and not
>> recover.  When that happens, some of its registers indicate it is
>> failing to do DMA reads, so cannot reclaim entries on its ring buffer.
>>
>> I bisected the problem into this commit:
>>
>> commit bcb81ac6ae3c2ef95b44e7b54c3c9522364a245c
>> Author: Robin Murphy <robin.murphy@arm.com>
>> Date:   Fri Feb 28 15:46:33 2025 +0000
>>
>>       iommu: Get DT/ACPI parsing into the proper probe path
>>
>> The problem still exists on 6.19-rc1, on pci/next (29a77b4897f1) and on
>> iommu/master (360e85353769) trees.  Reverting the commit fixes the issue.

The problem persists on 6.19-rc5

>> The system is a Gateworks GW7200, which is a i.MX 8 Mini connected to a
>> Pericom
>> PI7C9X2G404 4-port switch connected to the LAN7430 chip.
>>
>> -[0000:00]---00.0-[01-ff]----00.0-[02-05]--+-01.0-[03]----00.0
>>                                              +-02.0-[04]--
>>                                              \-03.0-[05]----00.0
>>
>> The problem only occurs when there is at least another PCI device in use
>> on the
>> switch.  It does not happen if the LAN7430 is the only PCI device, or if
>> the
>> other devices are not actively used.  For example i can reproduce it
>> with an
>> ath9k wireless network adapter when it is up and running, but not when
>> it is
>> down or its driver is not loaded.
>>
>> I suspect that other PCI devices have similar issues, but the LAN7430 is
>> the
>> easiest one to diagnose, as it hangs within seconds with an iperf3 --
>> bidir -u
>> -b 200M and its register map are public.
>>
>> I couldn't find an way to dump the PCI address translation mapping from
>> userspace.
>> I would be happy to provide more information or test patches.

I debugged it further, it seems to be mostly a PCI issue since the system does 
not actually have an IOMMU.

When examining changes in the PCI configuration (lspci -vvvv), the main 
difference is that, with the patch, Access Control Services are enabled on the 
PCI switch.

         Capabilities: [220 v1] Access Control Services
                 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl+ DirectTrans+
-               ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd- 
EgressCtrl- DirectTrans-
+               ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl- DirectTrans-

If I manually patch the config space in sysfs and re-disable ACS on the port 
connected to the LAN7430, I cannot reproduce the problem.  In fact, disabling 
only ReqRedir is enough to work around the issue.

I also read up on AER and I'm surprised that I don't see anything in dmesg when 
the problem occurs, even through UERcvd+ start appearing on the root context and 
AdvNonFatalErr+ appears on the switch.

>> ---- lspci -v

Instead, here is lspci -vvvv after the network card hangs.

00:00.0 PCI bridge: Synopsys, Inc. DWC_usb3 / PCIe bridge (rev 01) (prog-if 00 
[Normal decode])
         Device tree node: 
/sys/firmware/devicetree/base/soc@0/pcie@33800000/pcie@0,0
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR+ <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 202
         Region 0: Memory at 18000000 (32-bit, non-prefetchable) [size=1M]
         Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
         I/O behind bridge: f000-0fff [disabled] [16-bit]
         Memory behind bridge: 18100000-182fffff [size=2M] [32-bit]
         Prefetchable memory behind bridge: fff00000-000fffff [disabled] [32-bit]
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- <SERR+ <PERR-
         Expansion ROM at 18300000 [virtual] [disabled] [size=64K]
         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA 
PME(D0+,D1+,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable+ 64bit+
                 Address: 0000000040043000  Data: 0000
                 Masking: 00000000  Pending: 00000000
         Capabilities: [70] Express (v2) Root Port (Slot-), IntMsgNum 0
                 DevCap: MaxPayload 128 bytes, PhantFunc 0
                         ExtTag- RBE+ TEE-IO-
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
                 LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <1us, L1 <8us
                         ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp+
                 LnkCtl: ASPM L0s Enabled; RCB 64 bytes, LnkDisable- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+ FltModeDis-
                 LnkSta: Speed 5GT/s, Width x1
                         TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
                 RootCap: CRSVisible+
                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal- PMEIntEna+ 
CRSVisible+
                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP+ LTR-
                          10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
                          EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
                          FRS- LN System CLS Not Supported, TPHComp- ExtTPHComp- 
ARIFwd-
                          AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
                          AtomicOpsCtl: ReqEn- EgressBlck-
                          IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                 LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer- 
2Retimers- DRS-
                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB 
preshoot
                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
                          EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
                          Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
         Capabilities: [100 v2] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
                         ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
                 RootCmd: CERptEn+ NFERptEn+ FERptEn+
                 RootSta: CERcvd- MultCERcvd- UERcvd+ MultUERcvd-
                          FirstFatal- NonFatalMsg+ FatalMsg- IntMsgNum 0
                 ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0500
         Capabilities: [148 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1- 
L1_PM_Substates-
                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                 L1SubCtl2:
         Kernel driver in use: pcieport

01:00.0 PCI bridge: Pericom Semiconductor PI7C9X2G404 EV/SV PCIe2 4-Port/4-Lane 
Packet Switch (rev 01) (prog-if 00 [Normal decode])
         Device tree node: 
/sys/firmware/devicetree/base/soc@0/pcie@33800000/pcie@0,0/pcie@0,0
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Bus: primary=01, secondary=02, subordinate=05, sec-latency=0
         I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
         Memory behind bridge: 18100000-182fffff [size=2M] [32-bit]
         Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff 
[disabled] [64-bit]
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [4c] MSI: Enable- Count=1/4 Maskable+ 64bit+
                 Address: 0000000000000000  Data: 0000
                 Masking: 00000000  Pending: 00000000
         Capabilities: [64] Vendor Specific Information: Len=34 <?>
         Capabilities: [b0] Subsystem: Device 0000:0000
         Capabilities: [c0] Express (v2) Upstream Port, IntMsgNum 0
                 DevCap: MaxPayload 256 bytes, PhantFunc 0
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ SlotPowerLimit 
0W TEE-IO-
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 128 bytes
                 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ 
TransPend-
                 LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <512ns, L1 <1us
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
                 LnkCtl: ASPM Disabled; LnkDisable- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
                 LnkSta: Speed 5GT/s, Width x1
                         TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
                          10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
                          EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
                          FRS-
                          AtomicOpsCap: Routing-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                          AtomicOpsCtl: EgressBlck-
                          IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB 
preshoot
                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
                          EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
                          Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
         Capabilities: [100 v1] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
         Capabilities: [140 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=4
                 Arb:    Fixed- WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=04 MaxTimeSlots=128 RejSnoopTrans-
                         Arb:    Fixed+ WRR32- WRR64- WRR128+ TWRR128- WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                         Status: NegoPending- InProgress-
                         Port Arbitration Table <?>
         Capabilities: [20c v1] Power Budgeting <?>
         Capabilities: [230 v1] Latency Tolerance Reporting
                 Max snoop latency: 0ns
                 Max no snoop latency: 0ns
         Capabilities: [240 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+ 
L1_PM_Substates+
                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                 L1SubCtl2:
         Capabilities: [260 v1] Precision Time Measurement
                 PTMCap: Requester+ Responder+ Root+
                 PTMClockGranularity: Unimplemented
                 PTMControl: Enabled- RootSelected-
                 PTMEffectiveGranularity: Unknown
         Kernel driver in use: pcieport

02:01.0 PCI bridge: Pericom Semiconductor PI7C9X2G404 EV/SV PCIe2 4-Port/4-Lane 
Packet Switch (rev 01) (prog-if 00 [Normal decode])
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Bus: primary=02, secondary=03, subordinate=03, sec-latency=0
         I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
         Memory behind bridge: 18100000-181fffff [size=1M] [32-bit]
         Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff 
[disabled] [64-bit]
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [4c] MSI: Enable- Count=1/4 Maskable+ 64bit+
                 Address: 0000000000000000  Data: 0000
                 Masking: 00000000  Pending: 00000000
         Capabilities: [64] Vendor Specific Information: Len=34 <?>
         Capabilities: [b0] Subsystem: Device 0000:0000
         Capabilities: [c0] Express (v2) Downstream Port (Slot+), IntMsgNum 0
                 DevCap: MaxPayload 256 bytes, PhantFunc 0
                         ExtTag- RBE+ TEE-IO-
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 128 bytes
                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
                 LnkCap: Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <512ns, L1 <1us
                         ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp-
                 LnkCtl: ASPM Disabled; LnkDisable- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
                 LnkSta: Speed 2.5GT/s, Width x1
                         TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                         Slot #1, PowerLimit 0W; Interlock- NoCompl-
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
                         Control: AttnInd Off, PwrInd Off, Power- Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
                         Changed: MRL- PresDet- LinkState+
                 DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
                          10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
                          EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
                          FRS- ARIFwd-
                          AtomicOpsCap: Routing-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
                          AtomicOpsCtl: EgressBlck-
                          IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -3.5dB
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB 
preshoot
                 LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
                          EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
                          Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
         Capabilities: [100 v1] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
         Capabilities: [140 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=4
                 Arb:    Fixed- WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=04 MaxTimeSlots=128 RejSnoopTrans-
                         Arb:    Fixed+ WRR32- WRR64- WRR128+ TWRR128- WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                         Status: NegoPending- InProgress-
                         Port Arbitration Table <?>
         Capabilities: [20c v1] Power Budgeting <?>
         Capabilities: [220 v1] Access Control Services
                 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl+ DirectTrans+
                 ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl- DirectTrans-
         Capabilities: [240 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+ 
L1_PM_Substates+
                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                 L1SubCtl2:
         Capabilities: [250 v1] Downstream Port Containment
                 DpcCap: IntMsgNum 1, RPExt- PoisonedTLP- SwTrigger- RP PIO Log 
0, DL_ActiveErr-
                 DpcCtl: Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- 
DL_ActiveErr-
                 DpcSta: Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO 
ErrPtr:00
                 Source: 0000
         Kernel driver in use: pcieport

02:02.0 PCI bridge: Pericom Semiconductor PI7C9X2G404 EV/SV PCIe2 4-Port/4-Lane 
Packet Switch (rev 01) (prog-if 00 [Normal decode])
         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin ? routed to IRQ 203
         Bus: primary=02, secondary=04, subordinate=04, sec-latency=0
         I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
         Memory behind bridge: fff00000-000fffff [disabled] [32-bit]
         Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff 
[disabled] [64-bit]
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- <SERR- <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-
         Capabilities: [4c] MSI: Enable+ Count=1/4 Maskable+ 64bit+
                 Address: 0000000040043000  Data: 0001
                 Masking: 0000000e  Pending: 00000000
         Capabilities: [64] Vendor Specific Information: Len=34 <?>
         Capabilities: [b0] Subsystem: Device 0000:0000
         Capabilities: [c0] Express (v2) Downstream Port (Slot+), IntMsgNum 0
                 DevCap: MaxPayload 256 bytes, PhantFunc 0
                         ExtTag- RBE+ TEE-IO-
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 128 bytes
                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
                 LnkCap: Port #2, Speed 5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <512ns, L1 <1us
                         ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp-
                 LnkCtl: ASPM Disabled; LnkDisable- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt+ AutBWInt+ FltModeDis-
                 LnkSta: Speed 2.5GT/s, Width x1
                         TrErr- Train- SlotClk- DLActive- BWMgmt- ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                         Slot #2, PowerLimit 0W; Interlock- NoCompl-
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
                         Control: AttnInd Off, PwrInd Off, Power- Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
                         Changed: MRL- PresDet- LinkState-
                 DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
                          10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
                          EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
                          FRS- ARIFwd-
                          AtomicOpsCap: Routing-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
                          AtomicOpsCtl: EgressBlck-
                          IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -3.5dB
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB 
preshoot
                 LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
                          EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
                          Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
         Capabilities: [100 v1] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
         Capabilities: [140 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=4
                 Arb:    Fixed- WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=04 MaxTimeSlots=128 RejSnoopTrans-
                         Arb:    Fixed+ WRR32- WRR64- WRR128+ TWRR128- WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                         Status: NegoPending+ InProgress-
                         Port Arbitration Table <?>
         Capabilities: [20c v1] Power Budgeting <?>
         Capabilities: [220 v1] Access Control Services
                 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl+ DirectTrans+
                 ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl- DirectTrans-
         Capabilities: [240 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+ 
L1_PM_Substates+
                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                 L1SubCtl2:
         Capabilities: [250 v1] Downstream Port Containment
                 DpcCap: IntMsgNum 1, RPExt- PoisonedTLP- SwTrigger- RP PIO Log 
0, DL_ActiveErr-
                 DpcCtl: Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- 
DL_ActiveErr-
                 DpcSta: Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO 
ErrPtr:00
                 Source: 0000
         Kernel driver in use: pcieport

02:03.0 PCI bridge: Pericom Semiconductor PI7C9X2G404 EV/SV PCIe2 4-Port/4-Lane 
Packet Switch (rev 01) (prog-if 00 [Normal decode])
         Device tree node: 
/sys/firmware/devicetree/base/soc@0/pcie@33800000/pcie@0,0/pcie@0,0/pcie@3,0
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Bus: primary=02, secondary=05, subordinate=05, sec-latency=0
         I/O behind bridge: 0000f000-00000fff [disabled] [32-bit]
         Memory behind bridge: 18200000-182fffff [size=1M] [32-bit]
         Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff 
[disabled] [64-bit]
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- <SERR+ <PERR-
         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [4c] MSI: Enable- Count=1/4 Maskable+ 64bit+
                 Address: 0000000000000000  Data: 0000
                 Masking: 00000000  Pending: 00000000
         Capabilities: [64] Vendor Specific Information: Len=34 <?>
         Capabilities: [b0] Subsystem: Device 0000:0000
         Capabilities: [c0] Express (v2) Downstream Port (Slot+), IntMsgNum 0
                 DevCap: MaxPayload 256 bytes, PhantFunc 0
                         ExtTag- RBE+ TEE-IO-
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 128 bytes
                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ 
TransPend-
                 LnkCap: Port #3, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <512ns, L1 <1us
                         ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp-
                 LnkCtl: ASPM L1 Enabled; LnkDisable- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
                 LnkSta: Speed 2.5GT/s, Width x1
                         TrErr- Train- SlotClk- DLActive+ BWMgmt- ABWMgmt-
                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
                         Slot #3, PowerLimit 0W; Interlock- NoCompl-
                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet- CmdCplt- HPIrq- 
LinkChg-
                         Control: AttnInd Off, PwrInd Off, Power- Interlock-
                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
                         Changed: MRL- PresDet- LinkState+
                 DevCap2: Completion Timeout: Not Supported, TimeoutDis- 
NROPrPrP- LTR+
                          10BitTagComp- 10BitTagReq- OBFF Via message, ExtFmt- 
EETLPPrefix-
                          EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
                          FRS- ARIFwd-
                          AtomicOpsCap: Routing-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- ARIFwd-
                          AtomicOpsCtl: EgressBlck-
                          IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -3.5dB
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB 
preshoot
                 LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
                          EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
                          Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
         Capabilities: [100 v1] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
         Capabilities: [140 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=4
                 Arb:    Fixed- WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=04 MaxTimeSlots=128 RejSnoopTrans-
                         Arb:    Fixed+ WRR32- WRR64- WRR128+ TWRR128- WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                         Status: NegoPending- InProgress-
                         Port Arbitration Table <?>
         Capabilities: [20c v1] Power Budgeting <?>
         Capabilities: [220 v1] Access Control Services
                 ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl+ DirectTrans+
                 ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+ UpstreamFwd+ 
EgressCtrl- DirectTrans-
         Capabilities: [240 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1+ 
L1_PM_Substates+
                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                 L1SubCtl2:
         Capabilities: [250 v1] Downstream Port Containment
                 DpcCap: IntMsgNum 1, RPExt- PoisonedTLP- SwTrigger- RP PIO Log 
0, DL_ActiveErr-
                 DpcCtl: Trigger:0 Cmpl- INT- ErrCor- PoisonedTLP- SwTrigger- 
DL_ActiveErr-
                 DpcSta: Trigger- Reason:00 INT- RPBusy- TriggerExt:00 RP PIO 
ErrPtr:00
                 Source: 0000
         Kernel driver in use: pcieport

03:00.0 Network controller: Qualcomm Atheros AR93xx Wireless Network Adapter 
(rev 01)
         Subsystem: Qualcomm Atheros Device 3116
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx-
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx+
         Latency: 0, Cache Line Size: 64 bytes
         Interrupt: pin A routed to IRQ 201
         Region 0: Memory at 18100000 (64-bit, non-prefetchable) [size=128K]
         Expansion ROM at 18120000 [virtual] [disabled] [size=64K]
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=375mA 
PME(D0+,D1+,D2-,D3hot+,D3cold-)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable- Count=1/4 Maskable+ 64bit+
                 Address: 0000000000000000  Data: 0000
                 Masking: 00000000  Pending: 00000000
         Capabilities: [70] Express (v2) Endpoint, IntMsgNum 0
                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <1us, L1 
<8us
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 0W TEE-IO-
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- 
TransPend-
                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <2us, L1 <64us
                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp-
                 LnkCtl: ASPM L0s Enabled; RCB 64 bytes, LnkDisable- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
                 LnkSta: Speed 2.5GT/s, Width x1
                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Not Supported, TimeoutDis+ 
NROPrPrP- LTR-
                          10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- 
EETLPPrefix-
                          EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
                          FRS- TPHComp- ExtTPHComp-
                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                          AtomicOpsCtl: ReqEn-
                          IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB 
preshoot
                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- 
EqualizationPhase1-
                          EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
                          Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
         Capabilities: [100 v1] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr- CorrIntErr- HeaderOF-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
                 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- 
ECRCChkCap- ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
         Capabilities: [140 v1] Virtual Channel
                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                 Arb:    Fixed- WRR32- WRR64- WRR128-
                 Ctrl:   ArbSelect=Fixed
                 Status: InProgress-
                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                         Status: NegoPending- InProgress-
         Capabilities: [300 v1] Device Serial Number 00-00-00-00-00-00-00-00
         Kernel driver in use: ath9k
         Kernel modules: ath9k

05:00.0 Ethernet controller: Microchip Technology / SMSC LAN7430 (rev 11)
         Subsystem: Microchip Technology / SMSC LAN7430
         Device tree node: 
/sys/firmware/devicetree/base/soc@0/pcie@33800000/pcie@0,0/pcie@0,0/pcie@3,0/ethernet@0,0
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 201
         Region 0: Memory at 18200000 (64-bit, non-prefetchable) [size=8K]
         Region 2: Memory at 18202000 (64-bit, non-prefetchable) [size=256]
         Region 4: Memory at 18202100 (64-bit, non-prefetchable) [size=256]
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold-)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable- Count=1/8 Maskable+ 64bit+
                 Address: 0000000000000000  Data: 0000
                 Masking: 00000000  Pending: 00000000
         Capabilities: [70] Express (v2) Endpoint, IntMsgNum 0
                 DevCap: MaxPayload 512 bytes, PhantFunc 0, Latency L0s <512ns, 
L1 <32us
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 0W TEE-IO-
                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr+ NonFatalErr+ FatalErr- UnsupReq- AuxPwr- 
TransPend-
                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <1us, L1 <8us
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                 LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes, LnkDisable- CommClk-
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt- FltModeDis-
                 LnkSta: Speed 2.5GT/s, Width x1
                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
                          10BitTagComp- 10BitTagReq- OBFF Via message/WAKE#, 
ExtFmt- EETLPPrefix-
                          EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
                          FRS+ TPHComp- ExtTPHComp-
                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                          AtomicOpsCtl: ReqEn-
                          IDOReq- IDOCompl- LTR- EmergencyPowerReductionReq-
                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                 LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Retimer- 
2Retimers- DRS+
                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB 
preshoot
                 LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete- EqualizationPhase1-
                          EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
                          Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
         Capabilities: [b0] MSI-X: Enable+ Count=8 Masked-
                 Vector table: BAR=2 offset=00000000
                 PBA: BAR=4 offset=00000000
         Capabilities: [100 v2] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO+ CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP-
                         ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+
                         ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- 
AtomicOpBlocked- TLPBlockedErr-
                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- 
PCRC_CHECK- TLPXlatBlocked-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr- HeaderOF-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
                 AERCap: First Error Pointer: 0e, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
         Capabilities: [148 v1] Device Serial Number 00-d0-12-ff-ff-23-fa-8b
         Capabilities: [158 v1] Latency Tolerance Reporting
                 Max snoop latency: 0ns
                 Max no snoop latency: 0ns
         Capabilities: [160 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
                           PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                            T_CommonMode=0us LTR1.2_Threshold=0ns
                 L1SubCtl2: T_PwrOn=10us
         Capabilities: [170 v1] Vendor Specific Information: ID=0002 Rev=4 
Len=100 <?>
         Kernel driver in use: lan743x
         Kernel modules: lan743x

>> ---- dmesg:
>>
>> Booting Linux on physical CPU 0x0000000000 [0x410fd034]
>> Linux version 6.19.0-rc1 (buildroot@buildroot) (aarch64-buildroot-linux-
>> musl-gcc.br_real (Buildroot 2025.11-rc2-7266-g8a41889b4d) 14.3.0, GNU ld
>> (GNU Binutils) 2.43.1) #1 SMP PREEMPT Thu Dec 11 22:43:20 UTC 2025
>> KASLR disabled due to lack of seed
>> Machine model: Gateworks Venice GW72xx-0x i.MX8MM Development Kit
>> OF: reserved mem: Reserved memory: No reserved-memory node in the DT
>> Zone ranges:
>>     DMA      [mem 0x0000000040000000-0x00000000ffffffff]
>>     DMA32    empty
>>     Normal   [mem 0x0000000100000000-0x000000013fffffff]
>> Movable zone start for each node
>> Early memory node ranges
>>     node   0: [mem 0x0000000040000000-0x000000013fffffff]
>> Initmem setup node 0 [mem 0x0000000040000000-0x000000013fffffff]
>> cma: Reserved 32 MiB at 0x00000000fe000000
>> psci: probing for conduit method from DT.
>> psci: PSCIv1.1 detected in firmware.
>> psci: Using standard PSCI v0.2 function IDs
>> psci: MIGRATE_INFO_TYPE not supported.
>> psci: SMC Calling Convention v1.5
>> percpu: Embedded 22 pages/cpu s49304 r8192 d32616 u90112
>> pcpu-alloc: s49304 r8192 d32616 u90112 alloc=22*4096
>> pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
>> Detected VIPT I-cache on CPU0
>> CPU features: detected: GICv3 CPU interface
>> CPU features: detected: ARM erratum 845719
>> alternatives: applying boot alternatives
>> Kernel command line: root=/dev/mmcblk2p6 rootrw=/dev/mmcblk2p8
>> rootrwfstype=ext4 persistmnt=/dev/mmcblk2p7 persistmntfstype=ext4 init=/
>> sbin/wrap-init
>> Unknown kernel command line parameters "rootrw=/dev/mmcblk2p8
>> rootrwfstype=ext4 persistmnt=/dev/mmcblk2p7 persistmntfstype=ext4", will
>> be passed to user space.
>> printk: log buffer data + meta data: 131072 + 458752 = 589824 bytes
>> Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
>> Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
>> software IO TLB: area num 4.
>> software IO TLB: mapped [mem 0x00000000fa000000-0x00000000fe000000] (64MB)
>> Built 1 zonelists, mobility grouping on.  Total pages: 1048576
>> mem auto-init: stack:off, heap alloc:off, heap free:off
>> SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
>> rcu: Preemptible hierarchical RCU implementation.
>> rcu:     RCU event tracing is enabled.
>> rcu:     RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=4.
>>       Trampoline variant of Tasks RCU enabled.
>>       Tracing variant of Tasks RCU enabled.
>> rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
>> rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
>> RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1
>> rcu_task_cpu_ids=4.
>> RCU Tasks Trace: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1
>> rcu_task_cpu_ids=4.
>> NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
>> GICv3: GIC: Using split EOI/Deactivate mode
>> GICv3: 128 SPIs implemented
>> GICv3: 0 Extended SPIs implemented
>> Root IRQ handler: gic_handle_irq
>> GICv3: GICv3 features: 16 PPIs
>> GICv3: GICD_CTLR.DS=0, SCR_EL3.FIQ=1
>> GICv3: CPU0: found redistributor 0 region 0:0x0000000038880000
>> ITS: No ITS available, not enabling LPIs
>> rcu: srcu_init: Setting srcu_struct sizes based on contention.
>> arch_timer: cp15 timer running at 8.00MHz (phys).
>> clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles:
>> 0x1d854df40, max_idle_ns: 440795202120 ns
>> sched_clock: 56 bits at 8MHz, resolution 125ns, wraps every 2199023255500ns
>> Console: colour dummy device 80x25
>> printk: legacy console [tty0] enabled
>> Calibrating delay loop (skipped), value calculated using timer
>> frequency.. 16.00 BogoMIPS (lpj=32000)
>> pid_max: default: 32768 minimum: 301
>> Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
>> Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
>> rcu: Hierarchical SRCU implementation.
>> rcu:     Max phase no-delay instances is 1000.
>> Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode
>> level
>> smp: Bringing up secondary CPUs ...
>> Detected VIPT I-cache on CPU1
>> GICv3: CPU1: found redistributor 1 region 0:0x00000000388a0000
>> CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
>> Detected VIPT I-cache on CPU2
>> GICv3: CPU2: found redistributor 2 region 0:0x00000000388c0000
>> CPU2: Booted secondary processor 0x0000000002 [0x410fd034]
>> Detected VIPT I-cache on CPU3
>> GICv3: CPU3: found redistributor 3 region 0:0x00000000388e0000
>> CPU3: Booted secondary processor 0x0000000003 [0x410fd034]
>> smp: Brought up 1 node, 4 CPUs
>> SMP: Total of 4 processors activated.
>> CPU: All CPU(s) started at EL2
>> CPU features: detected: 32-bit EL0 Support
>> CPU features: detected: CRC32 instructions
>> CPU features: detected: PMUv3
>> alternatives: applying system-wide alternatives
>> Memory: 3998528K/4194304K available (8384K kernel code, 888K rwdata,
>> 2348K rodata, 896K init, 337K bss, 159960K reserved, 32768K cma-reserved)
>> devtmpfs: initialized
>> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff,
>> max_idle_ns: 7645041785100000 ns
>> posixtimers hash table entries: 2048 (order: 3, 32768 bytes, linear)
>> futex hash table entries: 1024 (65536 bytes on 1 NUMA nodes, total 64
>> KiB, linear).
>> 29504 pages in range for non-PLT usage
>> 521024 pages in range for PLT usage
>> NET: Registered PF_NETLINK/PF_ROUTE protocol family
>> DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
>> DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
>> DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
>> thermal_sys: Registered thermal governor 'step_wise'
>> cpuidle: using governor menu
>> hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
>> ASID allocator initialised with 65536 entries
>> /soc@0: Fixed dependency cycle(s) with /soc@0/bus@30000000/
>> efuse@30350000/unique-id@4
>> /soc@0/interrupt-controller@38800000: Fixed dependency cycle(s) with /
>> soc@0/interrupt-controller@38800000
>> /soc@0/bus@30000000/pinctrl@30330000: Fixed dependency cycle(s) with /
>> soc@0/bus@30000000/pinctrl@30330000/hoggrp
>> imx8mm-pinctrl 30330000.pinctrl: initialized IMX pinctrl driver
>> /soc@0/bus@30000000/efuse@30350000: Fixed dependency cycle(s) with /
>> soc@0/bus@30000000/clock-controller@30380000
>> /soc@0/bus@30000000/efuse@30350000: Fixed dependency cycle(s) with /
>> soc@0/bus@30000000/clock-controller@30380000
>> /soc@0/bus@30000000/clock-controller@30380000: Fixed dependency cycle(s)
>> with /soc@0/interrupt-controller@38800000
>> iommu: Default domain type: Translated
>> iommu: DMA domain TLB invalidation policy: strict mode
>> pps_core: LinuxPPS API ver. 1 registered
>> pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti
>> <giometti@linux.it>
>> EDAC MC: Ver: 3.0.0
>> vgaarb: loaded
>> clocksource: Switched to clocksource arch_sys_counter
>> VFS: Disk quotas dquot_6.6.0
>> VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
>> NET: Registered PF_INET protocol family
>> IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
>> tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768
>> bytes, linear)
>> Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
>> TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
>> TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
>> TCP: Hash tables configured (established 32768 bind 32768)
>> UDP hash table entries: 2048 (order: 5, 131072 bytes, linear)
>> UDP-Lite hash table entries: 2048 (order: 5, 131072 bytes, linear)
>> NET: Registered PF_UNIX/PF_LOCAL protocol family
>> PCI: CLS 0 bytes, default 64
>> ARM FF-A: FFA_VERSION returned not supported
>> Initialise system trusted keyrings
>> workingset: timestamp_bits=62 max_order=20 bucket_order=0
>> squashfs: version 4.0 (2009/01/31) Phillip Lougher
>> Key type asymmetric registered
>> Asymmetric key parser 'x509' registered
>> io scheduler mq-deadline registered
>> io scheduler kyber registered
>> mxs-dma 33000000.dma-controller: initialized
>> SoC: i.MX8MM revision 1.0
>> 30860000.serial: ttymxc0 at MMIO 0x30860000 (irq = 15, base_baud =
>> 1500000) is a IMX
>> 30880000.serial: ttymxc2 at MMIO 0x30880000 (irq = 16, base_baud =
>> 1500000) is a IMX
>> 30890000.serial: ttymxc1 at MMIO 0x30890000 (irq = 17, base_baud =
>> 1500000) is a IMX
>> imx-uart 30890000.serial: Console IMX rounded baud rate from 114286 to
>> 114300
>> printk: console [ttymxc1] enabled
>> 30a60000.serial: ttymxc3 at MMIO 0x30a60000 (irq = 18, base_baud =
>> 1500000) is a IMX
>> wireguard: WireGuard 1.0.0 loaded. See www.wireguard.com for information.
>> wireguard: Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>.
>> All Rights Reserved.
>> i2c_dev: i2c /dev entries driver
>> sdhci: Secure Digital Host Controller Interface driver
>> sdhci: Copyright(c) Pierre Ossman
>> sdhci-pltfm: SDHCI platform and OF driver helper
>> SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
>> caam 30900000.crypto: Entropy delay = 3200
>> caam 30900000.crypto: Entropy delay = 6400
>> caam 30900000.crypto: Instantiated RNG4 SH0
>> mmc2: SDHCI controller on 30b60000.mmc [30b60000.mmc] using ADMA
>> caam 30900000.crypto: Instantiated RNG4 SH1
>> caam 30900000.crypto: device ID = 0x0a16040100000000 (Era 9)
>> caam 30900000.crypto: job rings = 2, qi = 0
>> trusted_key: caam algorithms registered in /proc/crypto
>> caam 30900000.crypto: registering rng-caam
>> caam 30900000.crypto: rng crypto API alg registered prng-caam
>> mmc2: new HS400 Enhanced strobe MMC card at address 0001
>> mmcblk2: mmc2:0001 IY2964 58.3 GiB
>> hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 (0,8000003f)
>> counters available
>> nvmem imx-ocotp0: cell mac-address raw len 6 unaligned to nvmem word size 4
>> /soc@0: Fixed dependency cycle(s) with /soc@0/bus@30000000/efuse@30350000
>> NET: Registered PF_INET6 protocol family
>>    mmcblk2: p1 p2 < p5 p6 p7 p8 p9 >
>> Segment Routing with IPv6
>> In-situ OAM (IOAM) with IPv6
>> NET: Registered PF_PACKET protocol family
>> mmcblk2boot0: mmc2:0001 IY2964 4.00 MiB
>> registered taskstats version 1
>> Loading compiled-in X.509 certificates
>> mmcblk2boot1: mmc2:0001 IY2964 4.00 MiB
>> mmcblk2rpmb: mmc2:0001 IY2964 4.00 MiB, chardev (249:0)
>> gpio gpiochip0: Static allocation of GPIO base is deprecated, use
>> dynamic allocation.
>> gpio gpiochip1: Static allocation of GPIO base is deprecated, use
>> dynamic allocation.
>> random: crng init done
>> gpio gpiochip2: Static allocation of GPIO base is deprecated, use
>> dynamic allocation.
>> gpio gpiochip3: Static allocation of GPIO base is deprecated, use
>> dynamic allocation.
>> gpio gpiochip4: Static allocation of GPIO base is deprecated, use
>> dynamic allocation.
>> i2c i2c-0: using pinctrl states for GPIO recovery
>> i2c i2c-0: using generic GPIOs for recovery
>> gateworks-gsc 0-0020: Gateworks System Controller v66: fw 0xa691
>> pca953x 0-0023: supply vcc not found, using dummy regulator
>> pca953x 0-0023: using no auto increment
>> at24 0-0050: supply vcc not found, using dummy regulator
>> at24 0-0050: 256 byte 24c02 EEPROM, writable, 16 bytes/write
>> at24 0-0051: supply vcc not found, using dummy regulator
>> at24 0-0051: 256 byte 24c02 EEPROM, writable, 16 bytes/write
>> at24 0-0052: supply vcc not found, using dummy regulator
>> at24 0-0052: 256 byte 24c02 EEPROM, writable, 16 bytes/write
>> at24 0-0053: supply vcc not found, using dummy regulator
>> at24 0-0053: 256 byte 24c02 EEPROM, writable, 16 bytes/write
>> rtc-ds1672 0-0068: registered as rtc0
>> rtc-ds1672 0-0068: setting system clock to 2026-01-09T14:32:53 UTC
>> (1767969173)
>> i2c i2c-0: IMX I2C adapter registered
>> i2c i2c-1: using generic GPIOs for recovery
>> at24 1-0052: supply vcc not found, using dummy regulator
>> at24 1-0052: 4096 byte 24c32 EEPROM, writable, 32 bytes/write
>> i2c i2c-1: IMX I2C adapter registered
>> i2c i2c-2: IMX I2C adapter registered
>> imx6q-pcie 33800000.pcie: host bridge /soc@0/pcie@33800000 ranges:
>> imx6q-pcie 33800000.pcie: Parsing ranges property...
>> imx6q-pcie 33800000.pcie:       IO 0x001ff80000..0x001ff8ffff ->
>> 0x0000000000
>> imx6q-pcie 33800000.pcie:      MEM 0x0018000000..0x001fefffff ->
>> 0x0018000000
>> imx6q-pcie 33800000.pcie: config reg[1] 0x1ff00000 == cpu 0x1ff00000
>> ; no fixup was ever needed for this devicetree
>> imx-cpufreq-dt imx-cpufreq-dt: cpu speed grade 2 mkt segment 2
>> supported-hw 0x4 0x4
>> clk: Disabling unused clocks
>> PM: genpd: Disabling unused power domains
>> sdhci-esdhc-imx 30b50000.mmc: Got CD GPIO
>> check access for rdinit=/init failed: -2, ignoring
>> mmc1: SDHCI controller on 30b50000.mmc [30b50000.mmc] using ADMA
>> imx6q-pcie 33800000.pcie: Using 32 MSI vectors
>> imx6q-pcie 33800000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K, limit 4G
>> imx6q-pcie 33800000.pcie: PCIe Gen.2 x1 link up
>> imx6q-pcie 33800000.pcie: PCI host bridge to bus 0000:00
>> pci_bus 0000:00: root bus resource [bus 00-ff]
>> pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
>> pci_bus 0000:00: root bus resource [mem 0x18000000-0x1fefffff]
>> pci_bus 0000:00: scanning bus
>> pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400 PCIe Root Port
>> pci 0000:00:00.0: BAR 0 [mem 0x00000000-0x000fffff]
>> pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
>> pci 0000:00:00.0: PCI bridge to [bus 01-ff]
>> pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
>> pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
>> pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
>> pci 0000:00:00.0: supports D1
>> pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
>> pci 0000:00:00.0: PME# disabled
>> pci 0000:00:00.0: vgaarb: pci_notify
>> pci_bus 0000:00: fixups for bus
>> pci 0000:00:00.0: scanning [bus 01-ff] behind bridge, pass 0
>> pci_bus 0000:01: scanning bus
>> pci 0000:01:00.0: [12d8:b404] type 01 class 0x060400 PCIe Switch
>> Upstream Port
>> pci 0000:01:00.0: PCI bridge to [bus 00]
>> pci 0000:01:00.0:   bridge window [io  0x0000-0x0fff]
>> pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff]
>> pci 0000:01:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
>> pci 0000:01:00.0: supports D1 D2
>> pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
>> pci 0000:01:00.0: PME# disabled
>> pci 0000:01:00.0: PTM enabled (root), unknown granularity
>> pci 0000:01:00.0: vgaarb: pci_notify
>> pci 0000:01:00.0: ASPM: default states L0s L1
>> pci_bus 0000:01: fixups for bus
>> pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 0
>> pci 0000:01:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> pci 0000:01:00.0: scanning [bus 00-00] behind bridge, pass 1
>> pci_bus 0000:02: scanning bus
>> pci 0000:02:01.0: [12d8:b404] type 01 class 0x060400 PCIe Switch
>> Downstream Port
>> pci 0000:02:01.0: PCI bridge to [bus 00]
>> pci 0000:02:01.0:   bridge window [io  0x0000-0x0fff]
>> pci 0000:02:01.0:   bridge window [mem 0x00000000-0x000fffff]
>> pci 0000:02:01.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
>> pci 0000:02:01.0: supports D1 D2
>> pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
>> pci 0000:02:01.0: PME# disabled
>> pci 0000:02:01.0: vgaarb: pci_notify
>> pci 0000:02:02.0: [12d8:b404] type 01 class 0x060400 PCIe Switch
>> Downstream Port
>> pci 0000:02:02.0: PCI bridge to [bus 00]
>> pci 0000:02:02.0:   bridge window [io  0x0000-0x0fff]
>> pci 0000:02:02.0:   bridge window [mem 0x00000000-0x000fffff]
>> pci 0000:02:02.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
>> pci 0000:02:02.0: supports D1 D2
>> pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
>> pci 0000:02:02.0: PME# disabled
>> pci 0000:02:02.0: vgaarb: pci_notify
>> pci 0000:02:03.0: [12d8:b404] type 01 class 0x060400 PCIe Switch
>> Downstream Port
>> pci 0000:02:03.0: PCI bridge to [bus 00]
>> pci 0000:02:03.0:   bridge window [io  0x0000-0x0fff]
>> pci 0000:02:03.0:   bridge window [mem 0x00000000-0x000fffff]
>> pci 0000:02:03.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
>> pci 0000:02:03.0: supports D1 D2
>> pci 0000:02:03.0: PME# supported from D0 D1 D2 D3hot D3cold
>> pci 0000:02:03.0: PME# disabled
>> pci 0000:02:03.0: vgaarb: pci_notify
>> pci_bus 0000:02: fixups for bus
>> pci 0000:02:01.0: scanning [bus 00-00] behind bridge, pass 0
>> pci 0000:02:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> pci 0000:02:02.0: scanning [bus 00-00] behind bridge, pass 0
>> pci 0000:02:02.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> pci 0000:02:03.0: scanning [bus 00-00] behind bridge, pass 0
>> pci 0000:02:03.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>> pci 0000:02:01.0: scanning [bus 00-00] behind bridge, pass 1
>> pci_bus 0000:03: scanning bus
>> pci 0000:03:00.0: [168c:0030] type 00 class 0x028000 PCIe Endpoint
>> pci 0000:03:00.0: BAR 0 [mem 0x00000000-0x0001ffff 64bit]
>> pci 0000:03:00.0: ROM [mem 0x00000000-0x0000ffff pref]
>> pci 0000:03:00.0: supports D1
>> pci 0000:03:00.0: PME# supported from D0 D1 D3hot
>> pci 0000:03:00.0: PME# disabled
>> pci 0000:03:00.0: vgaarb: pci_notify
>> pci 0000:03:00.0: ASPM: default states L0s L1
>> pci_bus 0000:03: fixups for bus
>> pci_bus 0000:03: bus scan returning with max=03
>> pci_bus 0000:03: busn_res: [bus 03-ff] end is updated to 03
>> pci 0000:02:02.0: scanning [bus 00-00] behind bridge, pass 1
>> pci_bus 0000:04: scanning bus
>> pci_bus 0000:04: fixups for bus
>> pci_bus 0000:04: bus scan returning with max=04
>> pci_bus 0000:04: busn_res: [bus 04-ff] end is updated to 04
>> pci 0000:02:03.0: scanning [bus 00-00] behind bridge, pass 1
>> pci_bus 0000:05: scanning bus
>> pci 0000:05:00.0: [1055:7430] type 00 class 0x020000 PCIe Endpoint
>> pci 0000:05:00.0: BAR 0 [mem 0x00000000-0x00001fff 64bit]
>> pci 0000:05:00.0: BAR 2 [mem 0x00000000-0x000000ff 64bit]
>> pci 0000:05:00.0: BAR 4 [mem 0x00000000-0x000000ff 64bit]
>> pci 0000:05:00.0: PME# supported from D0 D3hot
>> pci 0000:05:00.0: PME# disabled
>> pci 0000:05:00.0: vgaarb: pci_notify
>> pci 0000:05:00.0: ASPM: default states L0s L1
>> pci_bus 0000:05: fixups for bus
>> pci_bus 0000:05: bus scan returning with max=05
>> pci_bus 0000:05: busn_res: [bus 05-ff] end is updated to 05
>> pci_bus 0000:02: bus scan returning with max=05
>> pci_bus 0000:02: busn_res: [bus 02-ff] end is updated to 05
>> pci_bus 0000:01: bus scan returning with max=05
>> pci 0000:00:00.0: scanning [bus 01-ff] behind bridge, pass 1
>> pci_bus 0000:00: bus scan returning with max=ff
>> pci 0000:02:01.0: bridge window [mem 0x00100000-0x001fffff] to [bus 03]
>> requires relaxed alignment rules
>> pci 0000:02:01.0: bridge window [mem 0x00100000-0x001fffff] to [bus 03]
>> requires relaxed alignment rules
>> pci 0000:02:03.0: bridge window [mem 0x00100000-0x001fffff] to [bus 05]
>> requires relaxed alignment rules
>> pci 0000:00:00.0: BAR 0 [mem 0x18000000-0x180fffff]: assigned
>> pci 0000:00:00.0: bridge window [mem 0x18100000-0x182fffff]: assigned
>> pci 0000:00:00.0: ROM [mem 0x18300000-0x1830ffff pref]: assigned
>> pci 0000:01:00.0: bridge window [mem 0x18100000-0x182fffff]: assigned
>> pci 0000:02:01.0: bridge window [mem 0x18100000-0x181fffff]: assigned
>> pci 0000:02:03.0: bridge window [mem 0x18200000-0x182fffff]: assigned
>> pci 0000:03:00.0: BAR 0 [mem 0x18100000-0x1811ffff 64bit]: assigned
>> pci 0000:03:00.0: ROM [mem 0x18120000-0x1812ffff pref]: assigned
>> pci 0000:02:01.0: PCI bridge to [bus 03]
>> pci 0000:02:01.0:   bridge window [mem 0x18100000-0x181fffff]
>> pci 0000:02:02.0: PCI bridge to [bus 04]
>> pci 0000:05:00.0: BAR 0 [mem 0x18200000-0x18201fff 64bit]: assigned
>> pci 0000:05:00.0: BAR 2 [mem 0x18202000-0x182020ff 64bit]: assigned
>> pci 0000:05:00.0: BAR 4 [mem 0x18202100-0x182021ff 64bit]: assigned
>> pci 0000:02:03.0: PCI bridge to [bus 05]
>> pci 0000:02:03.0:   bridge window [mem 0x18200000-0x182fffff]
>> pci 0000:01:00.0: PCI bridge to [bus 02-05]
>> pci 0000:01:00.0:   bridge window [mem 0x18100000-0x182fffff]
>> pci 0000:00:00.0: PCI bridge to [bus 01-ff]
>> pci 0000:00:00.0:   bridge window [mem 0x18100000-0x182fffff]
>> pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
>> pci_bus 0000:00: resource 5 [mem 0x18000000-0x1fefffff]
>> pci_bus 0000:01: resource 1 [mem 0x18100000-0x182fffff]
>> pci_bus 0000:02: resource 1 [mem 0x18100000-0x182fffff]
>> pci_bus 0000:03: resource 1 [mem 0x18100000-0x181fffff]
>> pci_bus 0000:05: resource 1 [mem 0x18200000-0x182fffff]
>> pci 0000:00:00.0: save config 0x00: 0xabcd16c3
>> pci 0000:00:00.0: save config 0x04: 0x00100107
>> pci 0000:00:00.0: save config 0x08: 0x06040001
>> pci 0000:00:00.0: save config 0x0c: 0x00010000
>> pci 0000:00:00.0: save config 0x10: 0x18000000
>> pci 0000:00:00.0: save config 0x14: 0x00000000
>> pci 0000:00:00.0: save config 0x18: 0x00ff0100
>> pci 0000:00:00.0: save config 0x1c: 0x000000f0
>> pci 0000:00:00.0: save config 0x20: 0x18201810
>> pci 0000:00:00.0: save config 0x24: 0x0000fff0
>> pci 0000:00:00.0: save config 0x28: 0x00000000
>> pci 0000:00:00.0: save config 0x2c: 0x00000000
>> pci 0000:00:00.0: save config 0x30: 0x00000000
>> pci 0000:00:00.0: save config 0x34: 0x00000040
>> pci 0000:00:00.0: save config 0x38: 0x00000000
>> pci 0000:00:00.0: save config 0x3c: 0x000201ff
>> pcieport 0000:00:00.0: vgaarb: pci_notify
>> pcieport 0000:00:00.0: assign IRQ: got 201
>> imx6q-pcie 33800000.pcie: msi#0 address_hi 0x0 address_lo 0x4007e000
>> pcieport 0000:00:00.0: PME: Signaling with IRQ 202
>> pcieport 0000:00:00.0: AER: enabled with IRQ 202
>> pcieport 0000:00:00.0: bwctrl: enabled with IRQ 202
>> pcieport 0000:00:00.0: save config 0x00: 0xabcd16c3
>> pcieport 0000:00:00.0: save config 0x04: 0x00100507
>> pcieport 0000:00:00.0: save config 0x08: 0x06040001
>> pcieport 0000:00:00.0: save config 0x0c: 0x00010000
>> pcieport 0000:00:00.0: save config 0x10: 0x18000000
>> pcieport 0000:00:00.0: save config 0x14: 0x00000000
>> pcieport 0000:00:00.0: save config 0x18: 0x00ff0100
>> pcieport 0000:00:00.0: save config 0x1c: 0x000000f0
>> pcieport 0000:00:00.0: save config 0x20: 0x18201810
>> pcieport 0000:00:00.0: save config 0x24: 0x0000fff0
>> pcieport 0000:00:00.0: save config 0x28: 0x00000000
>> pcieport 0000:00:00.0: save config 0x2c: 0x00000000
>> pcieport 0000:00:00.0: save config 0x30: 0x00000000
>> pcieport 0000:00:00.0: save config 0x34: 0x00000040
>> pcieport 0000:00:00.0: save config 0x38: 0x00000000
>> pcieport 0000:00:00.0: save config 0x3c: 0x000201c9
>> pcieport 0000:00:00.0: vgaarb: pci_notify
>> pci 0000:01:00.0: save config 0x00: 0xb40412d8
>> pci 0000:01:00.0: save config 0x04: 0x00100000
>> pci 0000:01:00.0: save config 0x08: 0x06040001
>> pci 0000:01:00.0: save config 0x0c: 0x00010000
>> pci 0000:01:00.0: save config 0x10: 0x00000000
>> pci 0000:01:00.0: save config 0x14: 0x00000000
>> pci 0000:01:00.0: save config 0x18: 0x00050201
>> pci 0000:01:00.0: save config 0x1c: 0x000001f1
>> pci 0000:01:00.0: save config 0x20: 0x18201810
>> pci 0000:01:00.0: save config 0x24: 0x0001fff1
>> pci 0000:01:00.0: save config 0x28: 0x00000000
>> pci 0000:01:00.0: save config 0x2c: 0x00000000
>> pci 0000:01:00.0: save config 0x30: 0x00000000
>> pci 0000:01:00.0: save config 0x34: 0x00000040
>> pci 0000:01:00.0: save config 0x38: 0x00000000
>> pci 0000:01:00.0: save config 0x3c: 0x00020000
>> pcieport 0000:01:00.0: vgaarb: pci_notify
>> pcieport 0000:01:00.0: assign IRQ: got 0
>> pcieport 0000:01:00.0: enabling device (0000 -> 0002)
>> pcieport 0000:01:00.0: save config 0x00: 0xb40412d8
>> pcieport 0000:01:00.0: save config 0x04: 0x00100002
>> pcieport 0000:01:00.0: save config 0x08: 0x06040001
>> pcieport 0000:01:00.0: save config 0x0c: 0x00010000
>> pcieport 0000:01:00.0: save config 0x10: 0x00000000
>> pcieport 0000:01:00.0: save config 0x14: 0x00000000
>> pcieport 0000:01:00.0: save config 0x18: 0x00050201
>> pcieport 0000:01:00.0: save config 0x1c: 0x000001f1
>> pcieport 0000:01:00.0: save config 0x20: 0x18201810
>> pcieport 0000:01:00.0: save config 0x24: 0x0001fff1
>> pcieport 0000:01:00.0: save config 0x28: 0x00000000
>> pcieport 0000:01:00.0: save config 0x2c: 0x00000000
>> pcieport 0000:01:00.0: save config 0x30: 0x00000000
>> pcieport 0000:01:00.0: save config 0x34: 0x00000040
>> pcieport 0000:01:00.0: save config 0x38: 0x00000000
>> pcieport 0000:01:00.0: save config 0x3c: 0x00020000
>> pcieport 0000:01:00.0: vgaarb: pci_notify
>> pci 0000:02:01.0: save config 0x00: 0xb40412d8
>> pci 0000:02:01.0: save config 0x04: 0x00100000
>> pci 0000:02:01.0: save config 0x08: 0x06040001
>> pci 0000:02:01.0: save config 0x0c: 0x00010000
>> pci 0000:02:01.0: save config 0x10: 0x00000000
>> pci 0000:02:01.0: save config 0x14: 0x00000000
>> pci 0000:02:01.0: save config 0x18: 0x00030302
>> pci 0000:02:01.0: save config 0x1c: 0x000001f1
>> pci 0000:02:01.0: save config 0x20: 0x18101810
>> pci 0000:02:01.0: save config 0x24: 0x0001fff1
>> pci 0000:02:01.0: save config 0x28: 0x00000000
>> pci 0000:02:01.0: save config 0x2c: 0x00000000
>> pci 0000:02:01.0: save config 0x30: 0x00000000
>> pci 0000:02:01.0: save config 0x34: 0x00000040
>> pci 0000:02:01.0: save config 0x38: 0x00000000
>> pci 0000:02:01.0: save config 0x3c: 0x00020000
>> pcieport 0000:02:01.0: vgaarb: pci_notify
>> pcieport 0000:02:01.0: assign IRQ: got 0
>> pcieport 0000:01:00.0: enabling bus mastering
>> pcieport 0000:02:01.0: enabling device (0000 -> 0002)
>> pcieport 0000:02:01.0: save config 0x00: 0xb40412d8
>> pcieport 0000:02:01.0: save config 0x04: 0x00100002
>> pcieport 0000:02:01.0: save config 0x08: 0x06040001
>> pcieport 0000:02:01.0: save config 0x0c: 0x00010000
>> pcieport 0000:02:01.0: save config 0x10: 0x00000000
>> pcieport 0000:02:01.0: save config 0x14: 0x00000000
>> pcieport 0000:02:01.0: save config 0x18: 0x00030302
>> pcieport 0000:02:01.0: save config 0x1c: 0x000001f1
>> pcieport 0000:02:01.0: save config 0x20: 0x18101810
>> pcieport 0000:02:01.0: save config 0x24: 0x0001fff1
>> pcieport 0000:02:01.0: save config 0x28: 0x00000000
>> pcieport 0000:02:01.0: save config 0x2c: 0x00000000
>> pcieport 0000:02:01.0: save config 0x30: 0x00000000
>> pcieport 0000:02:01.0: save config 0x34: 0x00000040
>> pcieport 0000:02:01.0: save config 0x38: 0x00000000
>> pcieport 0000:02:01.0: save config 0x3c: 0x00020000
>> pcieport 0000:02:01.0: vgaarb: pci_notify
>> pci 0000:02:02.0: save config 0x00: 0xb40412d8
>> pci 0000:02:02.0: save config 0x04: 0x00100000
>> pci 0000:02:02.0: save config 0x08: 0x06040001
>> pci 0000:02:02.0: save config 0x0c: 0x00010000
>> pci 0000:02:02.0: save config 0x10: 0x00000000
>> pci 0000:02:02.0: save config 0x14: 0x00000000
>> pci 0000:02:02.0: save config 0x18: 0x00040402
>> pci 0000:02:02.0: save config 0x1c: 0x000001f1
>> pci 0000:02:02.0: save config 0x20: 0x0000fff0
>> pci 0000:02:02.0: save config 0x24: 0x0001fff1
>> pci 0000:02:02.0: save config 0x28: 0x00000000
>> pci 0000:02:02.0: save config 0x2c: 0x00000000
>> pci 0000:02:02.0: save config 0x30: 0x00000000
>> pci 0000:02:02.0: save config 0x34: 0x00000040
>> pci 0000:02:02.0: save config 0x38: 0x00000000
>> pci 0000:02:02.0: save config 0x3c: 0x00020000
>> pcieport 0000:02:02.0: vgaarb: pci_notify
>> pcieport 0000:02:02.0: assign IRQ: got 0
>> pcieport 0000:02:02.0: enabling bus mastering
>> imx6q-pcie 33800000.pcie: msi#4 address_hi 0x0 address_lo 0x4007e000
>> imx6q-pcie 33800000.pcie: msi#5 address_hi 0x0 address_lo 0x4007e000
>> imx6q-pcie 33800000.pcie: msi#6 address_hi 0x0 address_lo 0x4007e000
>> imx6q-pcie 33800000.pcie: msi#7 address_hi 0x0 address_lo 0x4007e000
>> imx6q-pcie 33800000.pcie: msi#1 address_hi 0x0 address_lo 0x4007e000
>> pcieport 0000:02:02.0: bwctrl: enabled with IRQ 203
>> pcieport 0000:02:02.0: save config 0x00: 0xb40412d8
>> pcieport 0000:02:02.0: save config 0x04: 0x00100404
>> pcieport 0000:02:02.0: save config 0x08: 0x06040001
>> pcieport 0000:02:02.0: save config 0x0c: 0x00010000
>> pcieport 0000:02:02.0: save config 0x10: 0x00000000
>> pcieport 0000:02:02.0: save config 0x14: 0x00000000
>> pcieport 0000:02:02.0: save config 0x18: 0x00040402
>> pcieport 0000:02:02.0: save config 0x1c: 0x000001f1
>> pcieport 0000:02:02.0: save config 0x20: 0x0000fff0
>> pcieport 0000:02:02.0: save config 0x24: 0x0001fff1
>> pcieport 0000:02:02.0: save config 0x28: 0x00000000
>> pcieport 0000:02:02.0: save config 0x2c: 0x00000000
>> pcieport 0000:02:02.0: save config 0x30: 0x00000000
>> pcieport 0000:02:02.0: save config 0x34: 0x00000040
>> pcieport 0000:02:02.0: save config 0x38: 0x00000000
>> pcieport 0000:02:02.0: save config 0x3c: 0x00020000
>> pcieport 0000:02:02.0: vgaarb: pci_notify
>> pci 0000:02:03.0: save config 0x00: 0xb40412d8
>> pci 0000:02:03.0: save config 0x04: 0x00100000
>> pci 0000:02:03.0: save config 0x08: 0x06040001
>> pci 0000:02:03.0: save config 0x0c: 0x00010000
>> pci 0000:02:03.0: save config 0x10: 0x00000000
>> pci 0000:02:03.0: save config 0x14: 0x00000000
>> pci 0000:02:03.0: save config 0x18: 0x00050502
>> pci 0000:02:03.0: save config 0x1c: 0x000001f1
>> pci 0000:02:03.0: save config 0x20: 0x18201820
>> pci 0000:02:03.0: save config 0x24: 0x0001fff1
>> pci 0000:02:03.0: save config 0x28: 0x00000000
>> pci 0000:02:03.0: save config 0x2c: 0x00000000
>> pci 0000:02:03.0: save config 0x30: 0x00000000
>> pci 0000:02:03.0: save config 0x34: 0x00000040
>> pci 0000:02:03.0: save config 0x38: 0x00000000
>> pci 0000:02:03.0: save config 0x3c: 0x00020000
>> pcieport 0000:02:03.0: vgaarb: pci_notify
>> pcieport 0000:02:03.0: assign IRQ: got 0
>> pcieport 0000:02:03.0: enabling device (0000 -> 0002)
>> pcieport 0000:02:03.0: save config 0x00: 0xb40412d8
>> pcieport 0000:02:03.0: save config 0x04: 0x00100002
>> pcieport 0000:02:03.0: save config 0x08: 0x06040001
>> pcieport 0000:02:03.0: save config 0x0c: 0x00010000
>> pcieport 0000:02:03.0: save config 0x10: 0x00000000
>> pcieport 0000:02:03.0: save config 0x14: 0x00000000
>> pcieport 0000:02:03.0: save config 0x18: 0x00050502
>> pcieport 0000:02:03.0: save config 0x1c: 0x000001f1
>> pcieport 0000:02:03.0: save config 0x20: 0x18201820
>> pcieport 0000:02:03.0: save config 0x24: 0x0001fff1
>> pcieport 0000:02:03.0: save config 0x28: 0x00000000
>> pcieport 0000:02:03.0: save config 0x2c: 0x00000000
>> pcieport 0000:02:03.0: save config 0x30: 0x00000000
>> pcieport 0000:02:03.0: save config 0x34: 0x00000040
>> pcieport 0000:02:03.0: save config 0x38: 0x00000000
>> pcieport 0000:02:03.0: save config 0x3c: 0x00020000
>> pcieport 0000:02:03.0: vgaarb: pci_notify
>> pci 0000:03:00.0: save config 0x00: 0x0030168c
>> pci 0000:03:00.0: save config 0x04: 0x00100000
>> pci 0000:03:00.0: save config 0x08: 0x02800001
>> pci 0000:03:00.0: save config 0x0c: 0x00000000
>> pci 0000:03:00.0: save config 0x10: 0x18100004
>> pci 0000:03:00.0: save config 0x14: 0x00000000
>> pci 0000:03:00.0: save config 0x18: 0x00000000
>> pci 0000:03:00.0: save config 0x1c: 0x00000000
>> pci 0000:03:00.0: save config 0x20: 0x00000000
>> pci 0000:03:00.0: save config 0x24: 0x00000000
>> pci 0000:03:00.0: save config 0x28: 0x00000000
>> pci 0000:03:00.0: save config 0x2c: 0x3116168c
>> pci 0000:03:00.0: save config 0x30: 0x00000000
>> pci 0000:03:00.0: save config 0x34: 0x00000040
>> pci 0000:03:00.0: save config 0x38: 0x00000000
>> pci 0000:03:00.0: save config 0x3c: 0x000001ff
>> pci 0000:05:00.0: save config 0x00: 0x74301055
>> pci 0000:05:00.0: save config 0x04: 0x00100000
>> pci 0000:05:00.0: save config 0x08: 0x02000011
>> pci 0000:05:00.0: save config 0x0c: 0x00000000
>> pci 0000:05:00.0: save config 0x10: 0x18200004
>> pci 0000:05:00.0: save config 0x14: 0x00000000
>> pci 0000:05:00.0: save config 0x18: 0x18202004
>> pci 0000:05:00.0: save config 0x1c: 0x00000000
>> pci 0000:05:00.0: save config 0x20: 0x18202104
>> pci 0000:05:00.0: save config 0x24: 0x00000000
>> pci 0000:05:00.0: save config 0x28: 0x00000000
>> pci 0000:05:00.0: save config 0x2c: 0x74301055
>> pci 0000:05:00.0: save config 0x30: 0x00000000
>> pci 0000:05:00.0: save config 0x34: 0x00000040
>> pci 0000:05:00.0: save config 0x38: 0x00000000
>> pci 0000:05:00.0: save config 0x3c: 0x000001ff
>> VFS: Mounted root (squashfs filesystem) readonly on device 179:6.
>> devtmpfs: mounted
>> Freeing unused kernel memory: 896K
>> Run /sbin/wrap-init as init process
>>     with arguments:
>>       /sbin/wrap-init
>>     with environment:
>>       HOME=/
>>       TERM=linux
>>       rootrw=/dev/mmcblk2p8
>>       rootrwfstype=ext4
>>       persistmnt=/dev/mmcblk2p7
>>       persistmntfstype=ext4
>> pcieport 0000:02:02.0: save config 0x00: 0xb40412d8
>> pcieport 0000:02:02.0: save config 0x04: 0x00100404
>> pcieport 0000:02:02.0: save config 0x08: 0x06040001
>> pcieport 0000:02:02.0: save config 0x0c: 0x00010000
>> pcieport 0000:02:02.0: save config 0x10: 0x00000000
>> pcieport 0000:02:02.0: save config 0x14: 0x00000000
>> pcieport 0000:02:02.0: save config 0x18: 0x00040402
>> pcieport 0000:02:02.0: save config 0x1c: 0x000001f1
>> pcieport 0000:02:02.0: save config 0x20: 0x0000fff0
>> pcieport 0000:02:02.0: save config 0x24: 0x0001fff1
>> pcieport 0000:02:02.0: save config 0x28: 0x00000000
>> pcieport 0000:02:02.0: save config 0x2c: 0x00000000
>> pcieport 0000:02:02.0: save config 0x30: 0x00000000
>> pcieport 0000:02:02.0: save config 0x34: 0x00000040
>> pcieport 0000:02:02.0: save config 0x38: 0x00000000
>> pcieport 0000:02:02.0: save config 0x3c: 0x00020000
>> pcieport 0000:02:02.0: PME# enabled
>> imx-sdma 302c0000.dma-controller: loaded firmware 4.6
>> imx-sdma 302b0000.dma-controller: loaded firmware 4.6
>> imx-sdma 30bd0000.dma-controller: loaded firmware 4.6
>> usb_phy_generic usbphynop1: dummy supplies not allowed for exclusive
>> requests (id=vbus)
>> usb_phy_generic usbphynop2: dummy supplies not allowed for exclusive
>> requests (id=vbus)
>> usbcore: registered new interface driver usbfs
>> usbcore: registered new interface driver hub
>> usbcore: registered new device driver usb
>> cfg80211: Loading compiled-in X.509 certificates for regulatory database
>> Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
>> Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
>> ci_hdrc ci_hdrc.1: EHCI Host Controller
>> ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 1
>> ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
>> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002,
>> bcdDevice= 6.19
>> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
>> usb usb1: Product: EHCI Host Controller
>> usb usb1: Manufacturer: Linux 6.19.0-rc1 ehci_hcd
>> usb usb1: SerialNumber: ci_hdrc.1
>> hub 1-0:1.0: USB hub found
>> hub 1-0:1.0: 1 port detected
>> lan743x 0000:05:00.0: vgaarb: pci_notify
>> lan743x 0000:05:00.0: assign IRQ: got 201
>> pcieport 0000:02:03.0: enabling bus mastering
>> lan743x 0000:05:00.0: enabling device (0000 -> 0002)
>> lan743x 0000:05:00.0 (unnamed net_device) (uninitialized): PCI: Vendor
>> ID = 0x1055, Device ID = 0x7430
>> lan743x 0000:05:00.0: enabling bus mastering
>> lan743x 0000:05:00.0 (unnamed net_device) (uninitialized): ID_REV =
>> 0x74300011, FPGA_REV = 0.0
>> usb 1-1: new high-speed USB device number 2 using ci_hdrc
>> lan743x 0000:05:00.0 (unnamed net_device) (uninitialized): MAC address
>> set to 00:d0:12:23:fa:8b
>> lan743x 0000:05:00.0: vgaarb: pci_notify
>> usb 1-1: New USB device found, idVendor=0424, idProduct=2744, bcdDevice=
>> 2.21
>> usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>> usb 1-1: Product: USB2744
>> usb 1-1: Manufacturer: Microchip Tech
>> hub 1-1:1.0: USB hub found
>> hub 1-1:1.0: 5 ports detected
>> usb 1-1.5: new high-speed USB device number 3 using ci_hdrc
>> usb 1-1.5: New USB device found, idVendor=0424, idProduct=2740,
>> bcdDevice= 2.00
>> usb 1-1.5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>> usb 1-1.5: Product: Hub Controller
>> usb 1-1.5: Manufacturer: Microchip Tech
>> Generic PHY 30be0000.ethernet-1:00: attached PHY driver
>> (mii_bus:phy_addr=30be0000.ethernet-1:00, irq=POLL)
>> fec 30be0000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
>> Bluetooth: Core ver 2.22
>> NET: Registered PF_BLUETOOTH protocol family
>> Bluetooth: HCI device and connection manager initialized
>> Bluetooth: HCI socket layer initialized
>> Bluetooth: L2CAP socket layer initialized
>> Bluetooth: SCO socket layer initialized
>> Bluetooth: BNEP (Ethernet Emulation) ver 1.3
>> Bluetooth: BNEP filters: protocol multicast
>> Bluetooth: BNEP socket layer initialized
>> imx6q-pcie 33800000.pcie: msi#2 address_hi 0x0 address_lo 0x4007e000
>> imx6q-pcie 33800000.pcie: msi#3 address_hi 0x0 address_lo 0x4007e000
>> imx6q-pcie 33800000.pcie: msi#4 address_hi 0x0 address_lo 0x4007e000
>> imx6q-pcie 33800000.pcie: msi#5 address_hi 0x0 address_lo 0x4007e000
>> imx6q-pcie 33800000.pcie: msi#6 address_hi 0x0 address_lo 0x4007e000
>> imx6q-pcie 33800000.pcie: msi#7 address_hi 0x0 address_lo 0x4007e000
>> lan743x 0000:05:00.0 eth1: using MSIX interrupts, number of vectors = 6
>> lan743x 0000:05:00.0 eth1: PHY [pci-0000:05:00.0:01] driver [Generic
>> PHY] (irq=POLL)
>> lan743x 0000:05:00.0 eth1: configuring for phy/gmii link mode
>> lan743x 0000:05:00.0 eth1: Link is Up - 1Gbps/Full - flow control rx/tx
>> imx8m-blk-ctrl 38330000.blk-ctrl: sync_state() pending due to
>> 38310000.video-codec
>> imx8m-blk-ctrl 38330000.blk-ctrl: sync_state() pending due to
>> 38300000.video-codec
>> imx-pgc imx-pgc-domain.5: sync_state() pending due to 38008000.gpu
>> imx-pgc imx-pgc-domain.5: sync_state() pending due to 38000000.gpu
>> ath9k 0000:03:00.0: vgaarb: pci_notify
>> ath9k 0000:03:00.0: assign IRQ: got 201
>> pcieport 0000:02:01.0: enabling bus mastering
>> ath9k 0000:03:00.0: enabling device (0000 -> 0002)
>> ath9k 0000:03:00.0: enabling bus mastering
>> ath: EEPROM regdomain: 0x37
>> ath: EEPROM indicates we should expect a direct regpair map
>> ath: Country alpha2 being used: AL
>> ath: Regpair used: 0x37
>> ieee80211 phy0: Selected rate control algorithm 'minstrel_ht'
>> ieee80211 phy0: Atheros AR9300 Rev:3 mem=0x00000000ce8f30fa, irq=201
>> ath9k 0000:03:00.0: vgaarb: pci_notify
> 


