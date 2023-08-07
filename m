Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893577718FA
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 06:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjHGEZX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 00:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjHGEZW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 00:25:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C206107
        for <linux-pci@vger.kernel.org>; Sun,  6 Aug 2023 21:25:21 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3774Lq3Q003818;
        Mon, 7 Aug 2023 04:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=bCY1iQLX5jQU26UTsAGej8iHl1VL45Z9pgHuMcREgjw=;
 b=c54N+JeWC6fJwBgYHTjfAF2IiBfmpJOP4+JfLomsNkBhnqnvhRDGy8ZGUqRshPo1VGCo
 fHklSJc+X39L5KcJ99nhE8UKbBO5ZKmEYUqrL321z+8Ct9QMkdlVHTWBsGjkZw8XouRP
 8y0TsBW1n5c+FWFc67duzO7Dip5XZ+OG7w3JUzNO0hUprp2gTLRHs89xOhS9js0h7gtX
 xkZtIHCQCCrTTch8XcT4YqKhEGGu9A/+RFdllReGiLwvvg1W0IIeietS/0dhVdeyeipj
 rHAfEHPN8miiItJiwhvS/VKBd2yWAl+OvFmk9lT+cZN1wVdETK0XGZM2wuPKO04fiHuW Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sash3r1nd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 04:24:56 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3774OtZh014305;
        Mon, 7 Aug 2023 04:24:55 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sash3r1n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 04:24:55 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3772hj4p007593;
        Mon, 7 Aug 2023 04:24:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa14xt7ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 04:24:54 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3774OqbK524888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Aug 2023 04:24:52 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 170AB20043;
        Mon,  7 Aug 2023 04:24:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 175B820040;
        Mon,  7 Aug 2023 04:24:51 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  7 Aug 2023 04:24:51 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id DE1A5602FE;
        Mon,  7 Aug 2023 14:24:47 +1000 (AEST)
Message-ID: <7391a84d93269dae3650120f2791820c6c7feebe.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] PCI: Add pci_find_next_dvsec_capability to find
 next designated VSEC
From:   Andrew Donnellan <ajd@linux.ibm.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, bhelgaas@google.com,
        fbarrat@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, arnd@arndb.de,
        gregkh@linuxfoundation.org, ben.widawsky@intel.com
Cc:     jonathan.cameron@huawei.com, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, yangyingliang@huawei.com
Date:   Mon, 07 Aug 2023 14:24:47 +1000
In-Reply-To: <20230807031846.77348-2-wangxiongfeng2@huawei.com>
References: <20230807031846.77348-1-wangxiongfeng2@huawei.com>
         <20230807031846.77348-2-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VMgP92Rp4UOLirRZWqiDUSqQqbS7KnVt
X-Proofpoint-ORIG-GUID: wN0WF14gnpDF7WfdIEfEzdP6Ljs6oNWk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_01,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 adultscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070036
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2023-08-07 at 11:18 +0800, Xiongfeng Wang wrote:
> Some devices may have several DVSEC(Designated Vendor-Specific
> Extended
> Capability) entries with the same DVSEC ID. Add
> pci_find_next_dvsec_capability() to find them all.
>=20
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>=20

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>

> ---
> =C2=A0drivers/pci/pci.c=C2=A0=C2=A0 | 37 +++++++++++++++++++++++++-------=
-----
> =C2=A0include/linux/pci.h |=C2=A0 2 ++
> =C2=A02 files changed, 27 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 60230da957e0..3455ca7306ae 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -749,35 +749,48 @@ u16 pci_find_vsec_capability(struct pci_dev
> *dev, u16 vendor, int cap)
> =C2=A0EXPORT_SYMBOL_GPL(pci_find_vsec_capability);
> =C2=A0
> =C2=A0/**
> - * pci_find_dvsec_capability - Find DVSEC for vendor
> + * pci_find_next_dvsec_capability - Find next DVSEC for vendor
> =C2=A0 * @dev: PCI device to query
> + * @start: address at which to start looking (0 to start at
> beginning of list)
> =C2=A0 * @vendor: Vendor ID to match for the DVSEC
> =C2=A0 * @dvsec: Designated Vendor-specific capability ID
> =C2=A0 *
> - * If DVSEC has Vendor ID @vendor and DVSEC ID @dvsec return the
> capability
> - * offset in config space; otherwise return 0.
> + * Returns the address of the next DVSEC if the DVSEC has Vendor ID
> @vendor and
> + * DVSEC ID @dvsec; otherwise return 0. DVSEC can occur several
> times with the
> + * same DVSEC ID for some devices, and this provides a way to find
> them all.
> =C2=A0 */
> -u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16
> dvsec)
> +u16 pci_find_next_dvsec_capability(struct pci_dev *dev, u16 start,
> u16 vendor,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 dvsec)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int pos;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 pos =3D start;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pos =3D pci_find_ext_capabilit=
y(dev, PCI_EXT_CAP_ID_DVSEC);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!pos)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return 0;
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0while (pos) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0while ((pos =3D pci_find_next_=
ext_capability(dev, pos,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> PCI_EXT_CAP_ID_DVSEC))) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0u16 v, id;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0pci_read_config_word(dev, pos + PCI_DVSEC_HEADER1,
> &v);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0pci_read_config_word(dev, pos + PCI_DVSEC_HEADER2,
> &id);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (vendor =3D=3D v && dvsec =3D=3D id)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=
urn pos;
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0pos =3D pci_find_next_ext_capability(dev, pos,
> PCI_EXT_CAP_ID_DVSEC);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> =C2=A0}
> +EXPORT_SYMBOL_GPL(pci_find_next_dvsec_capability);
> +
> +/**
> + * pci_find_dvsec_capability - Find DVSEC for vendor
> + * @dev: PCI device to query
> + * @vendor: Vendor ID to match for the DVSEC
> + * @dvsec: Designated Vendor-specific capability ID
> + *
> + * If DVSEC has Vendor ID @vendor and DVSEC ID @dvsec return the
> capability
> + * offset in config space; otherwise return 0.
> + */
> +u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16
> dvsec)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return pci_find_next_dvsec_cap=
ability(dev, 0, vendor, dvsec);
> +}
> =C2=A0EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
> =C2=A0
> =C2=A0/**
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c69a2cc1f412..82bb905daf72 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1168,6 +1168,8 @@ u16 pci_find_next_ext_capability(struct pci_dev
> *dev, u16 pos, int cap);
> =C2=A0struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
> =C2=A0u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int
> cap);
> =C2=A0u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16
> dvsec);
> +u16 pci_find_next_dvsec_capability(struct pci_dev *dev, u16 start,
> u16 vendor,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 dvsec);
> =C2=A0
> =C2=A0u64 pci_get_dsn(struct pci_dev *dev);
> =C2=A0

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited
