Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7EC41AC28
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 11:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbhI1Jpt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 05:45:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17444 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S239863AbhI1Jpt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 05:45:49 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18S97vpv014053;
        Tue, 28 Sep 2021 05:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=uUKw5wtO6c6dujcfrh3Md6yH1CJyR0ZHqy+nT23AO1A=;
 b=IXjL3ZN4EIIjXcSTeNlvHsx5Ga6qB1/RDdRfumIj2dUauib2fT4t56TAYubEDsHTSx19
 40HYlfSQPYTBa7YvVl0ayi0tPm/v83848NxDVVwZps8Ube3etLRhK7C6nAWhQlLxeMvY
 HCAM5m5W4Z8fc5kNIKXHfvokQd2vQFX9OPpaL+29gW6oyR2oS3tv1hu87OZRla2WhjdF
 mV9SW9a+mw/VIccvvfLAvW1znL016P7NoE+QRLS0oHjrP9MtMJsIzgDHjtCq6W4DZONF
 qIFJh738Ows6eS5HBoTagjKKnDY3tvEUz9QOIuueFQL3kUdGTchh2MJVtPE+l6fhiu7j 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bbm8e676q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 05:44:09 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18S8hhsP029294;
        Tue, 28 Sep 2021 05:44:08 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3bbm8e676a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 05:44:08 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18S9XJ3H001593;
        Tue, 28 Sep 2021 09:44:07 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3b9ud9m8er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 09:44:06 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18S9i2D432965010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 09:44:02 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D932611C066;
        Tue, 28 Sep 2021 09:44:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BDF511C04C;
        Tue, 28 Sep 2021 09:44:02 +0000 (GMT)
Received: from sig-9-145-32-211.uk.ibm.com (unknown [9.145.32.211])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Sep 2021 09:44:02 +0000 (GMT)
Message-ID: <36a3121de8b86519f7bf1efba474d7597d134ced.camel@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] PCI: Export pci_dev_lock()
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linas Vepstas <linasvepstas@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Date:   Tue, 28 Sep 2021 11:44:02 +0200
In-Reply-To: <20210916093336.2895602-4-schnelle@linux.ibm.com>
References: <20210916093336.2895602-1-schnelle@linux.ibm.com>
         <20210916093336.2895602-4-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DVk78Mf8EyHPyGeJRhDcOsDvRXXPU9Dt
X-Proofpoint-ORIG-GUID: c9DSh1fv5AzoHNvfJL0gwp9zgo1JYxFU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 mlxscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280056
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2021-09-16 at 11:33 +0200, Niklas Schnelle wrote:
> Commit e3a9b1212b9d ("PCI: Export pci_dev_trylock() and pci_dev_unlock()")
> already exported pci_dev_trylock()/pci_dev_unlock() however in some
> circumstances such as during error recovery it makes sense to block
> waiting to get full access to the device so also export pci_dev_lock().
> 
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pci/pci.c   | 3 ++-
>  include/linux/pci.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ce2ab62b64cf..6fe810fdb796 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5059,12 +5059,13 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
>  	return pci_parent_bus_reset(dev, probe);
>  }
>  
> -static void pci_dev_lock(struct pci_dev *dev)
> +void pci_dev_lock(struct pci_dev *dev)
>  {
>  	pci_cfg_access_lock(dev);
>  	/* block PM suspend, driver probe, etc. */
>  	device_lock(&dev->dev);
>  }
> +EXPORT_SYMBOL_GPL(pci_dev_lock);
>  
>  /* Return 1 on successful lock, 0 on contention */
>  int pci_dev_trylock(struct pci_dev *dev)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cd8aa6fce204..c27c8fd1d30c 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1671,6 +1671,7 @@ void pci_cfg_access_lock(struct pci_dev *dev);
>  bool pci_cfg_access_trylock(struct pci_dev *dev);
>  void pci_cfg_access_unlock(struct pci_dev *dev);
>  
> +void pci_dev_lock(struct pci_dev *dev);
>  int pci_dev_trylock(struct pci_dev *dev);
>  void pci_dev_unlock(struct pci_dev *dev);
>  

Friendly ping. This now being the only common code change required and
with currently no known other issus, an Ack for this is the only thing
preventing this feature from going ahead. So any feedback would be
appreciated!

