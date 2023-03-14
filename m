Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E616B8CC8
	for <lists+linux-pci@lfdr.de>; Tue, 14 Mar 2023 09:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjCNINH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Mar 2023 04:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjCNIMJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Mar 2023 04:12:09 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E55F8615C
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 01:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678781438; x=1710317438;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X0KxmQowXDDwSTHyOkkSqL6l1rbqAQ9YKCBJzCgDIOw=;
  b=GKw4Qm6yp0WM3BAw4JfKsAFrCGdn5MYDm16Y3myTySfL+Vm1GVc5Gt+J
   rEMqddq6mi/XW4USTODqUs1LXUsJBBgV2g5is3Sv5tHezdXdysSH+ikMs
   x+kDlLKOpIdr7kCw2yOsPpjEplfvPOZ7EQP7qGdm71tWnEYZbnKCNGSL9
   LJ7El4iBKQ+JyW+PR8SgRHoW2hnDKGobaEGSeWpmDhhJnEYw7tnJG0Ken
   6sBDvdLFV67+Apg0aTeZO72M4QM1yVMQ/FjleVjN1jKcYtw1kSxK9b+UN
   dxJOqi5iXnzw2Wl6ntp9L0T4kXccym70PIgFaQQM/N06BnlDD+RwkW6SJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,259,1673884800"; 
   d="scan'208";a="225366745"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2023 16:10:36 +0800
IronPort-SDR: +X2v5SOyouS4Bjgxv9q6BaBIQcNGxZUFN9gj2WSXnywLQ5BOVBbeC/N/pLXFLSI0xmjPm+7yQw
 TKHeLCOWY/tC6ihGyXdXQ2a2paok5WXYdUuJ+ZfPYUOSCJTPY4aHjiSzPA8oaNsgAHGiU+H/b0
 Kf58mndhPf1oXhVpYO1XES3/fDPm97RqTRXU9lUYcaIwtEPxygiUgdXu92E1HAHHdKPVuJVSrd
 P9ck26ZpE4D7Iz9T6FBz7mN0Y7h5TES+FTKzOa+R01EVrLEzysAaYuOo8cR9wOtTww3FC0HdyX
 21Q=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 00:27:05 -0700
IronPort-SDR: chwMzcygTGyeNzwEhddafirq5dcKzWPhE2reoaKROU1Cu62gW45eQPpGQG6FboDscIBT0/sz16
 8Wm8xMG2HCpmLfBgyAdWRuhh3D+iXj0HiVUyPNhfN4w+C5OIEkgLr5GnoM/EFEgLqLvZ2fP+lF
 79uNhULBgtEWk4XpAuo7I/6vIoqIOP7GiM9MLBfKMnwKIzkkEY6robiY146oRAPmu7T59Itr3n
 qIX28I6FEpyex/mvQnCEb0lpiHcn2amymT/Wdj8VSm3gXLtgZZvInYig81hdDr+pGBOSWAvLZo
 Yp0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2023 01:10:37 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PbR6M6vZFz1RtVw
        for <linux-pci@vger.kernel.org>; Tue, 14 Mar 2023 01:10:35 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678781435; x=1681373436; bh=X0KxmQowXDDwSTHyOkkSqL6l1rbqAQ9YKCB
        JzCgDIOw=; b=aQkApqFk9I+MNhGHlB40yywZEUpsCVbJ29Z4NmlcgwGr0HSf9P7
        YNC/NpiufUwyDl6VB2D/wPgxPUOK0flCLsoGSsWAx2S55jQBoLX38U951lj8nXvV
        cKWvvV7n6D8OllDSGMqaVxNTKSiITVzzY/oxdmfr1e6XbWL0zhPro3aRaMEysKo0
        zibVPE/XxlYtiRJiqjeoMAgHOruplq+tmQYq1wqn124YlaAoNO2x+cNOBPqlLVO2
        2Dndp8naUWPs3/592xJE9aSqLxOCuZ3Mcr0L970x6oefAJmndFE+f5sIZzkq3t6t
        /pBxs69vHg9Q2L9LnDAvLtCiiLpH2dWc4Iw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 43WttepxgRR2 for <linux-pci@vger.kernel.org>;
        Tue, 14 Mar 2023 01:10:35 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PbR6H6r4sz1RtVm;
        Tue, 14 Mar 2023 01:10:31 -0700 (PDT)
Message-ID: <3c4ed614-f088-928f-2807-deaa5e4b668a@opensource.wdc.com>
Date:   Tue, 14 Mar 2023 17:10:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 0/9] PCI: rockchip: Fix RK3399 PCIe endpoint controller
 driver
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>
Cc:     alberto.dassatti@heig-vd.ch, xxm@rock-chips.com,
        rick.wertenbroek@heig-vd.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230214140858.1133292-1-rick.wertenbroek@gmail.com>
 <ecd09f27-b799-4741-2c5a-a2de99776c51@opensource.wdc.com>
 <CAAEEuhrk4cSC312UiAL3UwoDZ=urrdDcBThcNHd1dqnAuJTzAw@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <CAAEEuhrk4cSC312UiAL3UwoDZ=urrdDcBThcNHd1dqnAuJTzAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/14/23 16:57, Rick Wertenbroek wrote:
> On Tue, Mar 14, 2023 at 1:02=E2=80=AFAM Damien Le Moal
> <damien.lemoal@opensource.wdc.com> wrote:
>>
>> On 2/14/23 23:08, Rick Wertenbroek wrote:
>>> This is a series of patches that fixes the PCIe endpoint controller d=
river
>>> for the Rockchip RK3399 SoC. The driver was introduced in
>>> cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe control=
ler")
>>> The original driver had issues and would not allow for the RK3399 to
>>> operate in PCIe endpoint mode correctly. This patch series fixes that=
 so
>>> that the PCIe core controller of the RK3399 SoC can now act as a PCIe
>>> endpoint. This is v2 of the patch series and addresses the concerns t=
hat
>>> were raised during the review of the first version.
>>
>> Rick,
>>
>> Are you going to send a rebased V3 soon ? I have a couple of additiona=
l
>> patches to add on top of your series...
>>
>=20
> I'll try to send a V3 this week. The changes to V2 will be the issues
> raised and discussed on the V2 here in the mailing list with the additi=
onal
> code for removing the unsupported MSI-X capability list (was discussed
> in the mailing list as well).

Thanks.

Additional patch needed to avoid problems with this controller is that
we need to set ".align =3D 256" in the features. Otherwise, things do not
work well. This is because the ATU drops the low 8-bits of the PCI
addresses. It is a one liner patch, so feel free to add it to your series=
.

I also noticed random issues wich seem to be due to link-up timing... We
probably will need to implement a poll thread to detect and notify with
the linkup callback when we actually have the link established with the
host (see the dw-ep controller which does something similar).


From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Date: Thu, 9 Mar 2023 16:37:24 +0900
Subject: [PATCH] PCI: rockchip: Set address alignment for endpoint mode

The address translation unit of the rockchip EP controller does not use
the lower 8 bits of a PCIe-space address to map local memory. Thus we
must set the align feature field to 256 to let the user know about this
constraint.

Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c
b/drivers/pci/controller/pcie-rockchip-ep.c
index 12db9a9d92af..c6a23db84967 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -471,6 +471,7 @@ static const struct pci_epc_features
rockchip_pcie_epc_features =3D {
 	.linkup_notifier =3D false,
 	.msi_capable =3D true,
 	.msix_capable =3D false,
+	.align =3D 256,
 };

 static const struct pci_epc_features*
--=20
2.39.2


--=20
Damien Le Moal
Western Digital Research

