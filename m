Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3FC41C8B0
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 17:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244501AbhI2Prn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 11:47:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S245646AbhI2Prl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 11:47:41 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TFIXs5013454;
        Wed, 29 Sep 2021 11:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2lZJdFw4WNk77XQ3gfuFQ0Wu4AQF8qNlzBIEQyCzgpc=;
 b=T/0vUcqJAa2fgLtyzY4tlQYtWLN8QVM0E25FTA6Zi7YulGd8Xo7QJfagdJ75M9VcA0n3
 e5TU1HSXPryyf0I8/UZHPWxNlno2R4cb5TY22SkLbPnBHwC8BMRJtj9V5AzF/UaxwtuY
 6ozdx9pMD3nIp0LpRP23GSJCB1cwz/V1u4oNvhdKizQ58LwiDQ55qqO0voze+t0jMrsx
 Q7Gn6g+aahJZ8K19odhcjNOxEOq1cqhn6zoUOeptzFurvTZWEtFGYe4xAywRRaUxG/4p
 QvzXrQ/vp5FNVPs9hO+wNi1UTQtCH93tezwbf6qv5yeWPPACnypEMeCrGi7e+1XPjByB Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bcs3bkpay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Sep 2021 11:44:54 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18TFKswJ027183;
        Wed, 29 Sep 2021 11:44:53 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bcs3bkp9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Sep 2021 11:44:53 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18TFI54C008881;
        Wed, 29 Sep 2021 15:44:51 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3bc11evrnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Sep 2021 15:44:50 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18TFimIU46596452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Sep 2021 15:44:48 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E5C211C050;
        Wed, 29 Sep 2021 15:44:48 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70FD011C06E;
        Wed, 29 Sep 2021 15:44:47 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 29 Sep 2021 15:44:47 +0000 (GMT)
Received: from [9.206.131.40] (unknown [9.206.131.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 5834F600F5;
        Thu, 30 Sep 2021 01:44:45 +1000 (AEST)
Subject: Re: [PATCH v5 10/11] PCI: Replace pci_dev::driver usage by
 pci_dev::dev.driver
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Russell Currey <ruscur@russell.cc>,
        Jiri Olsa <jolsa@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kernel@pengutronix.de, Frederic Barrat <fbarrat@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
References: <20210929085306.2203850-1-u.kleine-koenig@pengutronix.de>
 <20210929085306.2203850-11-u.kleine-koenig@pengutronix.de>
 <75dd6d60-08b9-fa68-352c-3a0c5a04c0ab@linux.ibm.com>
 <20210929134330.e5c57t7mtwu5iner@pengutronix.de>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Message-ID: <1414b3c5-167c-c271-baed-d3d7f6cd0309@linux.ibm.com>
Date:   Thu, 30 Sep 2021 01:44:44 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210929134330.e5c57t7mtwu5iner@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xoS4V0L0XnAZXIlSObNRrRHFrN-qRdXU
X-Proofpoint-GUID: aqWPGKvFeDrRCpepuY6Q_1i7K4Jcg0AY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-29_06,2021-09-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 mlxlogscore=874
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109290092
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 29/9/21 11:43 pm, Uwe Kleine-König wrote:> I'm not a huge fan either, 
I used it to keep the control flow as is and
> without introducing several calls to to_pci_driver.
> 
> The whole code looks as follows:
> 
> 	list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
> 		struct pci_driver *afu_drv;
> 		if (afu_dev->dev.driver &&
> 		    (afu_drv = to_pci_driver(afu_dev->dev.driver))->err_handler &&
> 		    afu_drv->err_handler->resume)
> 			afu_drv->err_handler->resume(afu_dev);
> 	}
> 
> Without assignment in the if it could look as follows:
> 
> 	list_for_each_entry(afu_dev, &afu->phb->bus->devices, bus_list) {
> 		struct pci_driver *afu_drv;
> 
> 		if (!afu_dev->dev.driver)
> 			continue;
> 
> 		afu_drv = to_pci_driver(afu_dev->dev.driver));
> 
> 		if (afu_drv->err_handler && afu_drv->err_handler->resume)
> 			afu_drv->err_handler->resume(afu_dev);
> 	}
> 
> Fine for me.

This looks fine.

As an aside while writing my email I discovered the existence of 
container_of_safe(), a version of container_of() that handles the null 
and err ptr cases... if to_pci_driver() used that, the null check in the 
caller could be moved until after the to_pci_driver() call which would 
be neater.

But then, grep tells me that container_of_safe() is used precisely zero 
times in the entire tree. Interesting.

> (Sidenote: What happens if the device is unbound directly after the
> check for afu_dev->dev.driver? This is a problem the old code had, too
> (assuming it is a real problem, didn't check deeply).)

Looking at any of the cxl PCI error handling paths brings back 
nightmares from a few years ago... Fred: I wonder if we need to add a 
lock here?

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
