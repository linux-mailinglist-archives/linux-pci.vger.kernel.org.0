Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60D38183AFC
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 22:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgCLVCh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 17:02:37 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:6938 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726571AbgCLVCh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Mar 2020 17:02:37 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CL0g9K020498;
        Thu, 12 Mar 2020 17:02:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=OGjHjSkDalsOGQQ2r+7Ay0XVMN1U1hH8z+CvFp/s7jA=;
 b=t5lMlVn6rrp/9fDX6uFTBndH0/BpbER1hGjuwFWGXqxhtUSd8VCmwJwwak8NAy/f36nV
 HuGYCXNFFV1PrGcTKZj0hJJzSgIHGyvTWoKK9cAks6kvCX5vW6aWl4ckcaTNTbCAzU9F
 M9qtjf69Y0zS3TjaIkCyyPBaEMKEKXBFr0GcWgYOxTd0MU+hA5IqzabwBo894yw1JBgv
 95no9iyv8XWfVu0NzMkUUY9etE+kSYrw7gb2J5yK08D8nU0FRhEnY6M7ev0MoBL+jt4r
 984I4Gnnxhb4p2nLK/6CluOVerlUufCYZ4f+4CZHuD2Hw19c146unGQ6zw/D0vv8iGea uA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2yqt9srn2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Mar 2020 17:02:35 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CKlRmj130622;
        Thu, 12 Mar 2020 17:02:35 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0a-00154901.pphosted.com with ESMTP id 2yqtb220ym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 17:02:34 -0400
X-LoopCount0: from 10.166.132.134
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="465671033"
From:   <Austin.Bolen@dell.com>
To:     <helgaas@kernel.org>, <sathyanarayanan.kuppuswamy@linux.intel.com>
CC:     <Austin.Bolen@dell.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ashok.raj@intel.com>
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Thread-Topic: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Thread-Index: AQHV9oVCCTYsDGOZY0iqPe3akO+s+A==
Date:   Thu, 12 Mar 2020 21:02:28 +0000
Message-ID: <161a5d15809b47b09200f1806484b907@AUSX13MPC107.AMER.DELL.COM>
References: <20200312195319.GA162308@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-12_14:2020-03-11,2020-03-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003120104
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 mlxscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003120105
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/12/2020 2:53 PM, Bjorn Helgaas wrote:=0A=
> =0A=
> [EXTERNAL EMAIL]=0A=
> =0A=
> On Wed, Mar 11, 2020 at 04:07:59PM -0700, Kuppuswamy Sathyanarayanan wrot=
e:=0A=
>> On 3/11/20 3:23 PM, Bjorn Helgaas wrote:=0A=
>>> Is any synchronization needed here between the EDR path and the=0A=
>>> hotplug/enumeration path?=0A=
>>=0A=
>> If we want to follow the implementation note step by step (in=0A=
>> sequence) then we need some synchronization between EDR path and=0A=
>> enumeration path. But if it's OK to achieve the same end result by=0A=
>> following steps out of sequence then we don't need to create any=0A=
>> dependency between EDR and enumeration paths. Currently we follow=0A=
>> the latter approach.=0A=
> =0A=
> What would the synchronization look like?=0A=
> =0A=
> Ideally I think it would be better to follow the order in the=0A=
> flowchart if it's not too onerous.  That will make the code easier to=0A=
> understand.  The current situation with this dependency on pciehp and=0A=
> what it will do leaves a lot of things implicit.=0A=
> =0A=
> What happens if CONFIG_PCIE_EDR=3Dy but CONFIG_HOTPLUG_PCI_PCIE=3Dn?=0A=
> =0A=
> IIUC, when DPC triggers, pciehp is what fields the DLLSC interrupt and=0A=
> unbinds the drivers and removes the devices.  If that doesn't happen,=0A=
> and Linux clears the DPC trigger to bring the link back up, will those=0A=
> drivers try to operate uninitialized devices?=0A=
> =0A=
> Does EDR need a dependency on CONFIG_HOTPLUG_PCI_PCIE?=0A=
=0A=
 From one of Sathya's other responses:=0A=
=0A=
"If hotplug is not supported then there is support to enumerate=0A=
devices via polling  or ACPI events. But a point to note=0A=
here is, enumeration path is independent of error handler path, and=0A=
hence there is no explicit trigger or event from error handler path=0A=
to enumeration path to kick start the enumeration."=0A=
=0A=
The EDR standard doesn't have any dependency on hot-plug. It sounds like =
=0A=
in the current implementation there's some manual intervention needed if =
=0A=
hot-plug is not supported? Ideally recovery would kick in automatically =0A=
but requiring manual intervention is a good first step.=0A=
=0A=
> =0A=
>> For example, consider the case in flow chart where after sending=0A=
>> success _OST, firmware decides to stop the recovery of the device.=0A=
>>=0A=
>> if we follow the flow chart as is then the steps should be,=0A=
>>=0A=
>> 1. clear the DPC status trigger=0A=
>> 2. Send success code via _OST, and wait for return from _OST=0A=
>> 3. if successful return then enumerate the child devices and=0A=
>> reassign bus numbers.=0A=
>>=0A=
>> In current approach the steps followed are,=0A=
>>=0A=
>> 1. Clear the DPC status trigger.=0A=
>> 2. Send success code via _OST=0A=
=0A=
Success in step 2 is assuming device trained and config space is =0A=
accessible correct?  If device was removed or device config space is not =
=0A=
accessible then failure status should be sent via _OST.=0A=
=0A=
>> 2. In parallel, LINK UP event path will enumerate the child devices.=0A=
>> 3. if firmware decides not to recover the device,=A0then LINK DOWN=0A=
>> event will eventually remove them again.=0A=
> =0A=
=0A=
=0A=
