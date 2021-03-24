Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB06E34827F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 21:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbhCXUET (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 16:04:19 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:53078 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237868AbhCXUEO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Mar 2021 16:04:14 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12OJxjWp024480;
        Wed, 24 Mar 2021 13:04:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=oJx5lKDRubsPJA0zLgHd/q8/w9KEq53H1Cv4KvK4J74=;
 b=NecpB0Ai0IYL7hs/OYY4rfGUOMMcBLXFr6iDcahGa52ZZntKMNO6lwYPHZ5ZAObdmkT8
 24tORDFfz/juw9mME/KsMOeddlfMmGOluhmDVDdwBnnNR3+QfVAcDrd1+u2i+nxJ7izS
 U+eWZh+XcWMqwXzGq1fnjturOZJFP17YLxmKk8K4JxtogoPM7T+apPcyslfJX7BBtug4
 q84C6zFJI5CARMwykkKlX5XSrpoexlyRONffSw+ZFl9RLGZqUKhwCisKaIbTTIsNCrH1
 PYz0gMbmph1DTTz493JMaZ3rW0J9LyTBXXlrak2hg9q5vMQRt4jnhqnSqeqMeGJzKa5I Qg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 37ft17kkq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Mar 2021 13:04:11 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 Mar
 2021 13:04:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Mar 2021 13:04:09 -0700
Received: from irv1user01.caveonetworks.com (unknown [10.104.116.179])
        by maili.marvell.com (Postfix) with ESMTP id D9AE13F7040;
        Wed, 24 Mar 2021 13:04:09 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by irv1user01.caveonetworks.com (8.14.4/8.14.4/Submit) with ESMTP id 12OK49Kd024577;
        Wed, 24 Mar 2021 13:04:09 -0700
X-Authentication-Warning: irv1user01.caveonetworks.com: aeasi owned process doing -bs
Date:   Wed, 24 Mar 2021 13:04:09 -0700
From:   Arun Easi <aeasi@marvell.com>
X-X-Sender: aeasi@irv1user01.caveonetworks.com
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, Girish Basrur <GBasrur@marvell.com>,
        "Quinn Tran" <qutran@marvell.com>
Subject: Re: [PATCH 0/1] PCI/VPD: Fix blocking of VPD data in lspci for QLogic
 1077:2261
In-Reply-To: <20210303224250.12618-1-aeasi@marvell.com>
Message-ID: <alpine.LRH.2.21.9999.2103241301520.13940@irv1user01.caveonetworks.com>
References: <20210303224250.12618-1-aeasi@marvell.com>
User-Agent: Alpine 2.21.9999 (LRH 334 2019-03-29)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-24_13:2021-03-24,2021-03-24 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

A gentle reminder.

Regards,
-Arun

On Wed, 3 Mar 2021, 2:42pm, Arun Easi wrote:

> Hi Bjorn,
> 
> As discussed, re-sending the patch with updated commit message.
> You can disregard the earlier patch titled:
> 
> 	"[PATCH] PCI/VPD: Remove VPD quirk for QLogic 1077:2261"
> 
> Regards,
> -Arun
> 
> Arun Easi (1):
>   PCI/VPD: Fix blocking of VPD data in lspci for QLogic 1077:2261
> 
>  drivers/pci/vpd.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> 
