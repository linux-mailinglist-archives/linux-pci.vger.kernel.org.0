Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AE14541D9
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 08:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhKQHdE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 02:33:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233408AbhKQHdD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 02:33:03 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AH7HbC2020867;
        Wed, 17 Nov 2021 07:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=bNFd34ezwiZqnBtgPoeYXwUUMqrBSWwqwUBKwk+GOVU=;
 b=ADw4BufeU5UfRnqfKeI4zAU66Qt1Usuwc7IRKmKki2o39INPDLyXu4/MZtyfX8YOQ9Rg
 iWfFvfJWX86wKVwnbnjdFA9YMJguTdvxpE5pq64kMTjLUeoPVDGEJNBl/kepWE/uEEPO
 p1t5ox1gNvYuvKhg7d50WpseakInboEle8v6ZkCNyQ84g5Yd3O89hAAOj3cNpb9mufe7
 D3wkVGuUguqIMaxVW4l5QXT9CIuNQjhnQGNzENl1gRbtTrTKhqvINo33oXrufrFhwwzc
 UqCvf181SzL9R2FqJ4htne0L3eLF1kKdxzLLHy6lkqWJo9fbDZC11+rTeLYOLkNrwlqn jw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ccw7hr6mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 07:29:57 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AH7MY2k028541;
        Wed, 17 Nov 2021 07:29:55 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3ca50a5j9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 07:29:55 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AH7TrlI4588232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 07:29:53 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFE365204F;
        Wed, 17 Nov 2021 07:29:52 +0000 (GMT)
Received: from [9.145.179.29] (unknown [9.145.179.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6F2CF52059;
        Wed, 17 Nov 2021 07:29:52 +0000 (GMT)
Message-ID: <e9ad9495-362f-7350-84b7-dc9dd56dfa14@linux.ibm.com>
Date:   Wed, 17 Nov 2021 08:29:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [helgaas-pci:pci/driver 17/24] drivers/misc/cxl/guest.c:34:29:
 sparse: sparse: incorrect type in assignment (different modifiers)
Content-Language: en-US
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        kernel test robot <lkp@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, kbuild-all@lists.01.org,
        linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Donnellan <ajd@linux.ibm.com>
References: <202111121836.Oiqcphv0-lkp@intel.com> <YY5v0wzW192k1fG+@rocinante>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <YY5v0wzW192k1fG+@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UN_iDaVtkuvErwxmBaoeE3Zc6P-F9Fea
X-Proofpoint-ORIG-GUID: UN_iDaVtkuvErwxmBaoeE3Zc6P-F9Fea
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_02,2021-11-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 clxscore=1011 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170033
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

It looks like this has already been taken care of? By Bjorn?

   Fred


On 12/11/2021 14:44, Krzysztof Wilczyński wrote:
> [+CC Adding Jonathan, Dan, Frederic and Andrew for visibility]
> 
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/driver
>> head:   0508b6f72f055b88df518db4f3811bda9bb35da4
>> commit: 115c9d41e58388415f4956d0a988c90fb48663b9 [17/24] cxl: Factor out common dev->driver expressions
>> config: powerpc64-randconfig-s032-20211025 (attached as .config)
>> compiler: powerpc64-linux-gcc (GCC) 11.2.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # apt-get install sparse
>>          # sparse version: v0.6.4-dirty
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=115c9d41e58388415f4956d0a988c90fb48663b9
>>          git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
>>          git fetch --no-tags helgaas-pci pci/driver
>>          git checkout 115c9d41e58388415f4956d0a988c90fb48663b9
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> sparse warnings: (new ones prefixed by >>)
>>>> drivers/misc/cxl/guest.c:34:29: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct pci_error_handlers *err_handler @@     got struct pci_error_handlers const *err_handler @@
>>     drivers/misc/cxl/guest.c:34:29: sparse:     expected struct pci_error_handlers *err_handler
>>     drivers/misc/cxl/guest.c:34:29: sparse:     got struct pci_error_handlers const *err_handler
>>     drivers/misc/cxl/guest.c:108:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] phys_addr @@     got restricted __be64 [usertype] @@
>>     drivers/misc/cxl/guest.c:108:33: sparse:     expected unsigned long long [usertype] phys_addr
>>     drivers/misc/cxl/guest.c:108:33: sparse:     got restricted __be64 [usertype]
>>     drivers/misc/cxl/guest.c:109:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] len @@     got restricted __be64 [usertype] @@
>>     drivers/misc/cxl/guest.c:109:27: sparse:     expected unsigned long long [usertype] len
>>     drivers/misc/cxl/guest.c:109:27: sparse:     got restricted __be64 [usertype]
>>     drivers/misc/cxl/guest.c:111:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] len @@     got restricted __be64 [usertype] @@
>>     drivers/misc/cxl/guest.c:111:35: sparse:     expected unsigned long long [usertype] len
>>     drivers/misc/cxl/guest.c:111:35: sparse:     got restricted __be64 [usertype]
>>     drivers/misc/cxl/guest.c:443:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got unsigned short [usertype] * @@
>>     drivers/misc/cxl/guest.c:443:33: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
>>     drivers/misc/cxl/guest.c:443:33: sparse:     got unsigned short [usertype] *
>>     drivers/misc/cxl/guest.c:446:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int * @@
>>     drivers/misc/cxl/guest.c:446:33: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
>>     drivers/misc/cxl/guest.c:446:33: sparse:     got unsigned int *
>>     drivers/misc/cxl/guest.c:449:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned long long const volatile [noderef] [usertype] __iomem *addr @@     got unsigned long long [usertype] * @@
>>     drivers/misc/cxl/guest.c:449:33: sparse:     expected unsigned long long const volatile [noderef] [usertype] __iomem *addr
>>     drivers/misc/cxl/guest.c:449:33: sparse:     got unsigned long long [usertype] *
>>     drivers/misc/cxl/guest.c:537:23: sparse: sparse: invalid assignment: |=
>>     drivers/misc/cxl/guest.c:537:23: sparse:    left side has type restricted __be64
>>     drivers/misc/cxl/guest.c:537:23: sparse:    right side has type unsigned long long
>>     drivers/misc/cxl/guest.c:538:23: sparse: sparse: invalid assignment: |=
>>     drivers/misc/cxl/guest.c:538:23: sparse:    left side has type restricted __be64
>>     drivers/misc/cxl/guest.c:538:23: sparse:    right side has type unsigned long long
>>     drivers/misc/cxl/guest.c:540:31: sparse: sparse: invalid assignment: |=
>>     drivers/misc/cxl/guest.c:540:31: sparse:    left side has type restricted __be64
>>     drivers/misc/cxl/guest.c:540:31: sparse:    right side has type unsigned long long
>>     drivers/misc/cxl/guest.c:543:23: sparse: sparse: invalid assignment: |=
>>     drivers/misc/cxl/guest.c:543:23: sparse:    left side has type restricted __be64
>>     drivers/misc/cxl/guest.c:543:23: sparse:    right side has type unsigned long long
>>     drivers/misc/cxl/guest.c:544:23: sparse: sparse: invalid assignment: |=
>>     drivers/misc/cxl/guest.c:544:23: sparse:    left side has type restricted __be64
>>     drivers/misc/cxl/guest.c:544:23: sparse:    right side has type unsigned long long
>>     drivers/misc/cxl/guest.c:546:31: sparse: sparse: invalid assignment: |=
>>     drivers/misc/cxl/guest.c:546:31: sparse:    left side has type restricted __be64
>>     drivers/misc/cxl/guest.c:546:31: sparse:    right side has type unsigned long long
>>     drivers/misc/cxl/guest.c:549:31: sparse: sparse: invalid assignment: |=
>>     drivers/misc/cxl/guest.c:549:31: sparse:    left side has type restricted __be64
>>     drivers/misc/cxl/guest.c:549:31: sparse:    right side has type unsigned long long
>>     drivers/misc/cxl/guest.c:552:31: sparse: sparse: cast from restricted __be64
>> --
>>>> drivers/misc/cxl/pci.c:1816:29: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct pci_error_handlers *err_handler @@     got struct pci_error_handlers const *err_handler @@
>>     drivers/misc/cxl/pci.c:1816:29: sparse:     expected struct pci_error_handlers *err_handler
>>     drivers/misc/cxl/pci.c:1816:29: sparse:     got struct pci_error_handlers const *err_handler
>>     drivers/misc/cxl/pci.c:2041:37: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct pci_error_handlers *err_handler @@     got struct pci_error_handlers const *err_handler @@
>>     drivers/misc/cxl/pci.c:2041:37: sparse:     expected struct pci_error_handlers *err_handler
>>     drivers/misc/cxl/pci.c:2041:37: sparse:     got struct pci_error_handlers const *err_handler
>>     drivers/misc/cxl/pci.c:2090:37: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct pci_error_handlers *err_handler @@     got struct pci_error_handlers const *err_handler @@
>>     drivers/misc/cxl/pci.c:2090:37: sparse:     expected struct pci_error_handlers *err_handler
>>     drivers/misc/cxl/pci.c:2090:37: sparse:     got struct pci_error_handlers const *err_handler
>>
>> vim +34 drivers/misc/cxl/guest.c
>>
>>      17	
>>      18	static void pci_error_handlers(struct cxl_afu *afu,
>>      19					int bus_error_event,
>>      20					pci_channel_state_t state)
>>      21	{
>>      22		struct pci_dev *afu_dev;
>>      23		struct pci_driver *afu_drv;
>>      24		struct pci_error_handlers *err_handler;
>>      25	
>>      26		if (afu->phb == NULL)
>>      27			return;
>>      28	
>>      29		list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
>>      30			afu_drv = afu_dev->driver;
>>      31			if (!afu_drv)
>>      32				continue;
>>      33	
>>    > 34			err_handler = afu_drv->err_handler;
>>      35			switch (bus_error_event) {
>>      36			case CXL_ERROR_DETECTED_EVENT:
>>      37				afu_dev->error_state = state;
>>      38	
>>      39				if (err_handler &&
>>      40				    err_handler->error_detected)
>>      41					err_handler->error_detected(afu_dev, state);
>>      42				break;
>>      43			case CXL_SLOT_RESET_EVENT:
>>      44				afu_dev->error_state = state;
>>      45	
>>      46				if (err_handler &&
>>      47				    err_handler->slot_reset)
>>      48					err_handler->slot_reset(afu_dev);
>>      49				break;
>>      50			case CXL_RESUME_EVENT:
>>      51				if (err_handler &&
>>      52				    err_handler->resume)
>>      53					err_handler->resume(afu_dev);
>>      54				break;
>>      55			}
>>      56		}
>>      57	}
>>      58	
> 
> 	Krzysztof
> 
