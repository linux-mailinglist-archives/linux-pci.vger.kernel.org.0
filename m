Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D327C18098E
	for <lists+linux-pci@lfdr.de>; Tue, 10 Mar 2020 21:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgCJUtj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Mar 2020 16:49:39 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:55272 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726273AbgCJUtj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Mar 2020 16:49:39 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02AKgNFI013920;
        Tue, 10 Mar 2020 16:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=ci+/51ptKyE39a7YYyZ5UiDVa9nqAd5kk2CaifmmT6I=;
 b=GyMd7mCl4EMgtWDmpKkHPcbrl6O8H5tvx7q388gUiQuhEuL2cD6D5wFHIAJQx8T3/Ccg
 lLN/h7x7A0ZZFAnFhcAlxDNUkV+ivVgtAr9veqR5CivHHfRdllSNTUUBa/kgouHVw7In
 7UCjIPtegcEMqZH3taoosv2ElxfG9WV6sOIZq7j1Wz0bEtmnxhFr/DwHDJSSxylrCR+k
 2Lw1I2QtUOcqyAczdCjafBXN8CWjw95bGYFrY3tGIpb6oWHCPQPNk6mkAhdVUcrXaKMx
 s+ZLaLfiUETSJpKJWwH3g4DXTp4OIr3jU+MCZYZUPz4E5Oi3/60HN9E9M6cbx4hQoQp0 BA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2ym5k1mfg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Mar 2020 16:49:38 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02AKkPBu121591;
        Tue, 10 Mar 2020 16:49:37 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0a-00154901.pphosted.com with ESMTP id 2ym6qygxrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 16:49:37 -0400
X-LoopCount0: from 10.166.132.129
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1366226772"
From:   <Austin.Bolen@dell.com>
To:     <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <Austin.Bolen@dell.com>, <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ashok.raj@intel.com>
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Thread-Topic: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Thread-Index: AQHV9oVCCTYsDGOZY0iqPe3akO+s+A==
Date:   Tue, 10 Mar 2020 20:49:29 +0000
Message-ID: <c1fb95450690466eb562f48666902cd2@AUSX13MPC107.AMER.DELL.COM>
References: <20200310193257.GA170043@google.com>
 <38277b0f6c2e4c5d88e741b7354c72d1@AUSX13MPC107.AMER.DELL.COM>
 <8289f9b3-b9eb-6a80-1271-3db9aeef5161@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-10_13:2020-03-10,2020-03-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100123
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100122
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/10/2020 3:44 PM, Kuppuswamy Sathyanarayanan wrote:=0A=
> =0A=
<snip>=0A=
> =0A=
> Please check the following spec reference (change to 4.5.1 Table 4-6)=0A=
> =0A=
> the OS is permitted to read or write DPC Control and Status registers of =
a=0A=
> port while processing an Error Disconnect Recover notification from firmw=
are=0A=
> on that port. Error Disconnect Recover notification processing begins=0A=
> with the=0A=
> Error Disconnect Recover notify from Firmware, and *ends when the OS=0A=
> releases=0A=
> DPC by clearing the DPC Trigger Status bit*.Firmware can read DPC Trigger=
=0A=
> Status bit to determine the ownership of DPC Control and Status=0A=
> registers. Firmware=0A=
> is not permitted to write to DPC Control and Status registers if DPC=0A=
> Trigger Status is=0A=
> set i.e. the link is in DPC state. *Outside of the Error Disconnect=0A=
> Recover notification=0A=
> processing window, the OS is not permitted to modify DPC Control or=0A=
> Status registers*;=0A=
> only firmware is allowed to.=0A=
> =0A=
> Since the EDR processing window ends with clearing DPC Trigger status=0A=
> bit, OS needs to=0A=
> clear DPC and AER registers before it ends.=0A=
> =0A=
> Austin,=0A=
> =0A=
> I think the order needs to be reversed in the implementation note.=0A=
=0A=
Agreed.=0A=
