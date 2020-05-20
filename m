Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C471D1DBE60
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 21:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgETTuH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 15:50:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40008 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgETTuH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 15:50:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KJS6CT064040;
        Wed, 20 May 2020 19:50:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=/3Mo5PgRJ3CyTIvtRryo8NHUKD3p7unjMPfNjZTjC4k=;
 b=X76K0NO5n2AlPOXl9C8tfnjc9tsMdOX8UJ7g3W6wqh3XzyvsaZqyhGab/gyqy7orOiBF
 j7FM/UBqZ7htx9+WhKrtGs3zYXORQoJIRrEI8z1b0owi/Cr9l+/zEuGmMat0SsST+MDl
 Dw3nQnb+aKNzvX3UUzcvc96GbCcTi7msC2VMLlXlHE8iXRgrRCZAwy5SrAbiavAVTdQl
 Qp151XqEBzJtSDbFRYb4t9uUtDnNgd67aspV491tDEFzHs43qDwkOwmk2LXw4n3C5z0f
 Obe7jhpu8udUh7hBmYLvf9eKCoWydtFMWk2s9dK/RL7QrAWE9h5PQ4JqlK6277u9E8cg Cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31284m53bc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 19:50:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KJSTJF003879;
        Wed, 20 May 2020 19:48:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 314gm7nxb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 19:48:02 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04KJm2a9019464;
        Wed, 20 May 2020 19:48:02 GMT
Received: from [10.39.232.87] (/10.39.232.87)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 12:48:01 -0700
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, jonathan.derrick@intel.com,
        subhan.mohammed@oracle.com
From:   Thomas Tai <thomas.tai@oracle.com>
Subject: Question regarding PCI/AER: Enable reporting for ports enumerated
 after AER driver registration
Message-ID: <232b49b5-90cf-8eff-48cb-1bd6ce3a1977@oracle.com>
Date:   Wed, 20 May 2020 15:47:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005200155
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,
I have a question regarding "PCI/AER: Enable reporting for ports 
enumerated after AER driver registration" hope that you don't mind 
giving us some hints.

We found the patch mentioned in the following link fixes one of our 
issues where a device's AER was not enable correctly.

https://patchwork.ozlabs.org/project/linux-pci/patch/1536085989-2956-1-git-send-email-jonathan.derrick@intel.com/

I am wondering that if you are going to upstream the patch?

Thank you,
Thomas
