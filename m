Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595EC1DC007
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 22:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgETUXE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 16:23:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50836 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgETUXE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 16:23:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KKLf7l010954;
        Wed, 20 May 2020 20:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/t0BMRmbmeYbpsUWCCoPyXRLNO4pMdH3JkATy+9+/Bc=;
 b=YSShijL84sDnWqcuBiswuMMl1P88156b1q1ejQkb1TqpYse9NgeBeQo8amno27zX1168
 KFashGT8dFHfHNxF7NC1iUXz3wDCIwYdD+f0DM0s0DqfR56LBf8wSs62m9aJbE3jKL0s
 gqnN/a06cKx4Za+/wkshsYVHkhWSphytSkajEIPqDcEqIudlULPreEY5WCBOhe1KPpUD
 UsugxmUHi3wFIaHc1KnT0sFyiQlhh6zKQEmUHcohkXZrQVTpHXmOSP5M4OJkcHCscgZX
 NKPpVnMnLfwAlJ2a9D8ug2bvPKXI5ekgp2COqA6IKatfP1yU0DWWCfm9QI/AA3j1rzxh JA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31501rbs2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 20:23:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KKJBKv056276;
        Wed, 20 May 2020 20:20:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 312t38phk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 20:20:59 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04KKKxK4019824;
        Wed, 20 May 2020 20:20:59 GMT
Received: from [192.168.1.12] (/45.3.7.105)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 13:20:58 -0700
Subject: Re: Question regarding PCI/AER: Enable reporting for ports enumerated
 after AER driver registration
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "subhan.mohammed@oracle.com" <subhan.mohammed@oracle.com>
References: <232b49b5-90cf-8eff-48cb-1bd6ce3a1977@oracle.com>
 <d9c3371d476c849ccf1aef5fd1b0971c68a8c48e.camel@intel.com>
From:   Thomas Tai <thomas.tai@oracle.com>
Message-ID: <2c745033-9326-ceff-fe3f-91e4d7de7784@oracle.com>
Date:   Wed, 20 May 2020 16:20:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d9c3371d476c849ccf1aef5fd1b0971c68a8c48e.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005200161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200161
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-05-20 4:09 p.m., Derrick, Jonathan wrote:
> Hi Thomas,
> 
> On Wed, 2020-05-20 at 15:47 -0400, Thomas Tai wrote:
>> Hi Bjorn,
>> I have a question regarding "PCI/AER: Enable reporting for ports
>> enumerated after AER driver registration" hope that you don't mind
>> giving us some hints.
>>
>> We found the patch mentioned in the following link fixes one of our
>> issues where a device's AER was not enable correctly.
>>
>> https://patchwork.ozlabs.org/project/linux-pci/patch/1536085989-2956-1-git-send-email-jonathan.derrick@intel.com/
>>
>> I am wondering that if you are going to upstream the patch?
>>
>> Thank you,
>> Thomas
> 
> I suspect you could be seeing issues due to the firmware-first
> dependencies. Your platform could be requiring FFS via HEST which is
> affecting Native AER in non-ACPI domains.
> 
> There were some recent commits to converge FFS to _OSC only:
> https://marc.info/?l=linux-pci&m=158834532728113&w=2

Hi Jonathan,
Thank you very much for your quick response, I will give that a try.

Thanks,
Thomas

> 
> Could you try Bjorn's latest branch ?
> 
> There is also a DPC set for Native DPC which I will be resending soon:
> https://marc.info/?l=linux-pci&m=158835454431698&w=2
> 
> 
