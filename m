Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F3077572
	for <lists+linux-pci@lfdr.de>; Sat, 27 Jul 2019 02:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfG0Ake (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Jul 2019 20:40:34 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:34688 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbfG0Ake (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Jul 2019 20:40:34 -0400
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6R0eI43030754;
        Fri, 26 Jul 2019 20:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=ep8q1zgBemRtJXbAXKWjrrPyXJWLfHJA16v15yzVht8=;
 b=MKMoN9Wz6MW3pPHgL5ealXXJplJ018JvfehVAZwtohhIndhADFQXJB1LNNyr7+DkQeNE
 R8z5dNIDA6/sh0n2ZijPfXgZRmCxFSbnrWpE0gBhKmvEG6JK+GENiOKO5wCuPmwLHj6J
 39xagzsfY8796ZqleB8N+8wiNhg7ERf10u6ogwgOx0KOBE4SYbMIz3gjAHDNwRiii8Q0
 L9cUQqflsnIq5o8sVBC1EEJwz8xtq7Hz75KLyrBD+KeH3I01n7PpZ65QGgosv77H5NAo
 sY/CVF4NdapBU6BDGUMiuiepQN8oCbW/zDrSi6OzACLHcQlYL42lJUCNM4QdpI1xEO+S MQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 2u08d4gsnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 20:40:33 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6R0XF1O016851;
        Fri, 26 Jul 2019 20:34:43 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0b-00154901.pphosted.com with ESMTP id 2u081navjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Jul 2019 20:34:42 -0400
X-LoopCount0: from 10.166.132.134
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="401000745"
From:   <Austin.Bolen@dell.com>
To:     <sathyanarayanan.kuppuswamy@linux.intel.com>, <kbusch@kernel.org>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ashok.raj@intel.com>,
        <keith.busch@intel.com>, <Austin.Bolen@dell.com>,
        <Huong.Nguyen@dell.com>
Subject: Re: [PATCH v6 0/9] Add Error Disconnect Recover (EDR) support
Thread-Topic: [PATCH v6 0/9] Add Error Disconnect Recover (EDR) support
Thread-Index: AQHVRAqUeMPp4LVQZEOz/0HmhsAqJA==
Date:   Sat, 27 Jul 2019 00:34:40 +0000
Message-ID: <79eefd85ecc140cfb2811901089c6c47@AUSX13MPC107.AMER.DELL.COM>
References: <cover.1564177080.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20190726215311.GA8720@localhost.localdomain>
 <683fffda-7116-a67b-02ab-503c0efc6853@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="windows-1256"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-27_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=896 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907270005
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907270007
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/26/2019 6:33 PM, sathyanarayanan kuppuswamy wrote:=0A=
> +Austin , Huong=0A=
>=0A=
> On 7/26/19 2:53 PM, Keith Busch wrote:=0A=
>> On Fri, Jul 26, 2019 at 02:43:10PM -0700, sathyanarayanan.kuppuswamy@lin=
ux.intel.com wrote:=0A=
>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.inte=
l.com>=0A=
>>>=0A=
>>> This patchset adds support for following features:=0A=
>>>=0A=
>>> 1. Error Disconnect Recover (EDR) support.=0A=
>>> 2. _OSC based negotiation support for DPC.=0A=
>>>=0A=
>>> You can find EDR spec in the following link.=0A=
>>>=0A=
>>> https://members.pcisig.com/wg/PCI-SIG/document/12614=0A=
>> Thank you for sticking with this. I've reviewed the series and I think=
=0A=
>> this looks good for the next merge window.=0A=
>>=0A=
>> Acked-by: Keith Busch <keith.busch@intel.com>=0A=
=0A=
Tested on a DPC-enabled PCIe switch (Broadcom PEX9733) in a Dell=0A=
PowerEdge R740xd.  Injected fatal and non-fatal errors on an NVMe=0A=
endpoint below the switch and on the switch downstream port itself and=0A=
verified errors were contained and then recovered at the PCIe level.=0A=
=0A=
Tested-by: Austin Bolen <Austin.Bolen@dell.com=FD>=0A=
=0A=
>>=0A=
=0A=
