Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9DA7C845
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2019 18:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfGaQM6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 Jul 2019 12:12:58 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:30086 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725209AbfGaQM6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 Jul 2019 12:12:58 -0400
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VG9bon026232;
        Wed, 31 Jul 2019 12:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=bvuyEyYL0dYLQuXorPs3yeHCIRdNISCr/Vk2kCK/8jo=;
 b=Xr7DSeFBHEySVZFjVcTuWQtiLeyfzDjbO5EXS03DYvA7PdiZCpggN1d6+4qpJw3+emjp
 uhWstbziepwlfgLW+kHtXg6QDYloWA5UQ4EZH7xR0uhA9Yy9+KW8l9HDYurUABtMEUyS
 743o7tOVzmL74EQgdDfIjXtiNduiusFi2aE63LPiAkgzTMehIS3KnplyA9XtuTYBALFg
 56cIThISVUyZJY1CVXTpDLo9KXEH8WJkK4bAsry6bjPfVtlmFSWWKpp05ipCms1iC55A
 75dCUM7gH597K1tAntWsdl11kkmLwhcF+6fbYHno2To/1mSn9Xln694TQvLItxTczpUa rw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0a-00154904.pphosted.com with ESMTP id 2u2twectvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Jul 2019 12:12:57 -0400
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VG7rLi052078;
        Wed, 31 Jul 2019 12:12:56 -0400
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0b-00154901.pphosted.com with ESMTP id 2u3c0t2ntd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 12:12:56 -0400
X-LoopCount0: from 10.166.132.131
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="838363177"
From:   <Mario.Limonciello@dell.com>
To:     <kai.heng.feng@canonical.com>, <rjw@rjwysocki.net>
CC:     <mika.westerberg@linux.intel.com>, <anthony.wong@canonical.com>,
        <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] Commit "ACPI: PM: Allow transitions to D0 to occur
 in special cases"
Thread-Topic: [Regression] Commit "ACPI: PM: Allow transitions to D0 to occur
 in special cases"
Thread-Index: AQHVR7mqkcvT3R0NfUWTXYuokpN3/6bk5bx4
Date:   Wed, 31 Jul 2019 16:12:54 +0000
Message-ID: <1564589574204.11850@Dell.com>
References: <578BD3F1-B185-471B-A3EB-FF71BA34B822@canonical.com>
In-Reply-To: <578BD3F1-B185-471B-A3EB-FF71BA34B822@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.177.49.166]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=603 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310160
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=715 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907310161
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I've actually been seeing worse behavior, in that I can't get Thunderbolt t=
o work at all with 5.3rc1 or 5.3rc2 on the 9380 system I have on hand, simi=
lar messages related to link timeouts. =
