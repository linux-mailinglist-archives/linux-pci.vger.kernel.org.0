Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE841CC02B
	for <lists+linux-pci@lfdr.de>; Sat,  9 May 2020 12:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgEIKDN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 May 2020 06:03:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:38703 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgEIKDL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 May 2020 06:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589018576;
        bh=W7Lmspo0WENbbnXHZbdsbnw8T7Qb0HHacjX3ukXoMOE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=k6ki9ywtNE9qiCddSpl62DoOYp+bcWa1GlnXM977YrHrUxgFTDXqQIMKCDdDgTWFP
         2FaZQT5zX07AeyzRxuGn9gXO9G6YXrNfcr/+vl6lEy2VHaeRf+s+tkQ6TnguoECk1Z
         53ps5wlpGHWTSuNxmQh3zLufrw1Rc6b139wscyqA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.164] ([37.4.249.184]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QF5-1jWWqD2Hv3-001NMw; Sat, 09
 May 2020 12:02:56 +0200
Subject: Re: [PATCH v8 2/4] firmware: raspberrypi: Introduce vl805 init
 routine
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Rob Herring <robh@kernel.org>, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, helgaas@kernel.org,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        tim.gover@raspberrypi.org, linux-usb@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20200505161318.26200-1-nsaenzjulienne@suse.de>
 <20200505161318.26200-3-nsaenzjulienne@suse.de> <20200507214859.GA562@bogus>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <c9449111-f646-3925-36e6-f4492ad5f90a@gmx.net>
Date:   Sat, 9 May 2020 12:02:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507214859.GA562@bogus>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:eLZ1miKegv3rXdN/C0JNfEEqvpu73GO3hAnNewSExe7JComo0mJ
 z6ff9hhNKwJwZkB8eJvlrNfXubZKR/61QqP/CDU/+GIxpR4xqrJgDiOglWgofthjKSxILU2
 2nr3RGYACVmCbQRT1JmoDJ+nkAD+Khrg2VyyNlkvBNyPzteXLelXDNIzpVBXsBRhQ3D2zbr
 lu09VIpw4zbyGNOh+QySw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jsZDLKSi+Eg=:Tz2G7+Ln06ot1CiksLMqpf
 BhLX0+NE/qnW8Y2gL4sv0bMiUwoLqNx5DFFDTX3+KaVuYtgcD4x/yygk3OxMV3e0zztbY/Xwa
 UMLpPtmsHweaqFV2H+3NOPgmXDyjm+pgTruvTQ8Dx3EogZjiDq7SV0+wjM3azp7NqG04syBHm
 MC1qORRvtB1ey2cZDEtvAeBX9vt2VDijvk/nm1ll5+OQ3+Rw8iAf3IN3/bdyfOO9ZtdW5YuA2
 JqKU178JdykYeQrF0+f7V7wv8AvNlPh7eJqjZRHCUxAnk5xSkIlc+MR8B1VtU3qTLokoGtues
 EoTiUuXRo0YTWr59PvMi5uG3mq8O37OMSwoLOFI2f7q/UIkOKeGT79/GuxmN4/Tgdq937p1Q2
 2JgyKIqkxXIUrxudqp5LDRza4X3CVN5889ffN58ZCoIjCtm3QSqm83DIXmiahPAde2LarWDNy
 u3zw4dqTr+z1AeaE7MLxRhVlYqk2diAqY2FD5hXC3Nr3NTSg9F/H5HCclm/vfP0SQRUKBuqHq
 L1ceCtOdgzE4JYtRuzdU0tagCkSomKCUde/wcGbI/4hbz4+RsXokwY2YeUDZpl1+zCBrPw5bF
 JEokTtHLPkpStg92YrKoczLoCxiqcXclu3C48x+8uaEZte/nbMlvGt+tRPko6GkUXrmFi8Izg
 Nv3mBz3P2+clV7vTndCk/rZnJf+5qzF5F3VOa0Awtxg3mSfMzfhNnF64XaDGy9FQXBC6iHIYB
 cUFsj/O/n3yQ6AwNBO7VqmreQYyTl7U56ixeuwfBh/J7TZyVwmEbM9z+z13MSv8Y2k82PfHa4
 yEq2K02+Go8sMXm5sj4KMp5CtPUeMcR6eI9eBwcwkGdk5s1BfET10Ga7rb0WUp/6+xFTfVNJW
 crk/yNFcMUxl+R+TyHFMLBXfSfX8BySRDOUeGEB3qPjCJg36cASx7UiK7DpVCmyWSqLHlDUR+
 hJrNXMgBhtDfv5jfJXSstWyBpttYQWc+LhN8qdjnYz8yOWF1q2/EmmceL9GvqFbeV3RJIkBMs
 QXZg8pz+8rW+BIb7WzU7VTMHwv3q0l7Zlq/2jeY4lCnqD1GRNHtiN4ka0c0d1MHGl2yHBIVrs
 lkoyW2uulYGKEoNYXtFlB8jL89NREaK8pzV72SJ4KL4hGPwUpF9l/3oAIQpM9kLQDTnVvsVpS
 z6Hh0NS8E5uX51SoykLIajl9KxMywRj8t8JvsnTkyMDHTbsksjIRx/nbeCzqZ75mkRCHdj5og
 mBci+7MQhPqGeBxdR
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nicolas,

Am 07.05.20 um 23:48 schrieb Rob Herring:
> On Tue,  5 May 2020 18:13:15 +0200, Nicolas Saenz Julienne wrote:
>> The Raspberry Pi 4 gets its USB functionality from VL805, a PCIe chip
>> that implements xHCI. After a PCI reset, VL805's firmware may either be
>> loaded directly from an EEPROM or, if not present, by the SoC's
>> co-processor, VideoCore. RPi4's VideoCore OS contains both the non publ=
ic
>> firmware load logic and the VL805 firmware blob. The function this patc=
h
>> introduces triggers the aforementioned process.
>>
>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>
>> ---
>>
>> Change since v7:
>> - Use usleep_delay()
>> - Add comment about PCI errors
>> - Don't wait on error
>> - Typos
>>
>> Change since v6:
>> - Add test to avoid loading the firmware when not needed
>> - Since we have it around, print VL805's firmware version, it'll make
>> debugging easier in the future
>> - Correct typos
>> - Add a clearer view of HW topology in patch description
>>
>> Changes since v4:
>> - Inline function definition when RASPBERRYPI_FIRMWARE is not defined
>>
>> Changes since v1:
>> - Move include into .c file and add forward declaration to .h
>>
>>  drivers/firmware/raspberrypi.c             | 61 ++++++++++++++++++++++
>>  include/soc/bcm2835/raspberrypi-firmware.h |  7 +++
>>  2 files changed, 68 insertions(+)
>>
> Reviewed-by: Rob Herring <robh@kernel.org>

i modified the code a little bit for testing, but also successfully
tested it without my modifications:

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi=
.c
index 0d1422b..f3f4c2d 100644
=2D-- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -337,8 +337,10 @@ int rpi_firmware_init_vl805(struct pci_dev *pdev)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * further down the line.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_read_config_dword(pdev, VL8=
05_PCI_CONFIG_VERSION_OFFSET,
&version);
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (version)
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 goto exit;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (version) {
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 pci_info(pdev, "VL805 EEPROM firmware version %08x\n",
version);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return 0;
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_addr =3D pdev->bus->number =
<< 20 | PCI_SLOT(pdev->devfn) << 15 |
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCI_FUNC(pdev->devfn) << 12;
@@ -353,9 +355,8 @@ int rpi_firmware_init_vl805(struct pci_dev *pdev)
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_read_config_dword(pdev, VL8=
05_PCI_CONFIG_VERSION_OFFSET,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &version);
-exit:
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_info(pdev, "VL805 firmware versi=
on %08x\n", version);
=C2=A0
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pci_info(pdev, "VL805 RAM firmware v=
ersion %08x\n", version);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
=C2=A0}
=C2=A0EXPORT_SYMBOL_GPL(rpi_firmware_init_vl805);

Here are the my results with 3x Raspberry Pi 4:

VL805 EEPROM firmware version 000137ad
VL805 EEPROM firmware version 00013701
VL805 RAM firmware version 000137ad

So the whole patch series is:

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

