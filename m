Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3507B455241
	for <lists+linux-pci@lfdr.de>; Thu, 18 Nov 2021 02:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbhKRBhL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 20:37:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242277AbhKRBhG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 20:37:06 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AI0DJIC026916;
        Thu, 18 Nov 2021 01:33:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xn+sOmi8ndC4mBR3hUQSaLyvI8uirMt19YnrsauyzFU=;
 b=gcuC3FyFsNJvBcNi99WvaRh3cJjwv1HftEgO/cGl47mQDUKKTuvkaOykUjMmio6ITxIh
 oGdMEH7suvteDwOHbjYkJGAtsB4z+kWvEmtX9ssaOjLn/HI+fxP/9rcGb9UUkgEa8NTs
 ZGlaL98OdV90TDENem/lg983qlbFzCI98QT8C5JNjljXpw7oMDSTvnPrLW/8c+FBLdNw
 ZPZFdzwPVhgZcz55gBejj1GGFGZhvKw1x8d1OMYxPViOQEQgayuRYF0OquLTle4k/RWh
 /huq/mLVcUR9VlNh88RWqRvHX/qeZAk3P8SypQOxJ0n7uscbgjGpy9THqkmLIekXujs7 1w== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cdc3bs585-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 01:33:54 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AI1XFx1006361;
        Thu, 18 Nov 2021 01:33:53 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3ca4mk7vm4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Nov 2021 01:33:53 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AI1QpdJ61080060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 01:26:51 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF380A405B;
        Thu, 18 Nov 2021 01:33:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 593F0A4051;
        Thu, 18 Nov 2021 01:33:50 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 18 Nov 2021 01:33:50 +0000 (GMT)
Received: from [9.102.52.144] (unknown [9.102.52.144])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id B871860272;
        Thu, 18 Nov 2021 12:33:44 +1100 (AEDT)
Subject: Re: [helgaas-pci:pci/driver 17/24] drivers/misc/cxl/pci.c:1816:29:
 error: assignment discards 'const' qualifier from pointer target type
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        kernel test robot <lkp@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, kbuild-all@lists.01.org,
        linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>
References: <202111120955.M4Pkd0T4-lkp@intel.com> <YY3GbjLsnkUc/zhG@rocinante>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Message-ID: <180067dd-f640-d207-2ee7-6e84c54704f4@linux.ibm.com>
Date:   Thu, 18 Nov 2021 12:33:36 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YY3GbjLsnkUc/zhG@rocinante>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lf0WpNlGoZSTLtcCMFnnwBQFE6UyNdD_
X-Proofpoint-ORIG-GUID: lf0WpNlGoZSTLtcCMFnnwBQFE6UyNdD_
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_09,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 suspectscore=0 mlxlogscore=863 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180007
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/11/21 12:42 pm, Krzysztof Wilczyński wrote:
> [+CC Adding Jonathan, Dan, Frederic and Andrew for visibility]
> 
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/driver
>> head:   0508b6f72f055b88df518db4f3811bda9bb35da4
>> commit: 115c9d41e58388415f4956d0a988c90fb48663b9 [17/24] cxl: Factor out common dev->driver expressions
>> config: powerpc64-allnoconfig (attached as .config)

I think this issue has already been fixed, but I'm curious how 
CONFIG_CXL ended up being y in a supposed allnoconfig...


Andrew


-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
