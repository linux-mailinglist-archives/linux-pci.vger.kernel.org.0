Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36272216FF4
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 17:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgGGPNx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 11:13:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35166 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGPNx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jul 2020 11:13:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 067FBZpI056351;
        Tue, 7 Jul 2020 15:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=U1xPFwZZZWM/dKwwlYFIgRl131Rm3+3fn4LlImCeQwI=;
 b=GRj0Jd+R1Dkl4ulAD0eTkr0A97oC7f/4ibk2JrN3yAb42qAZ/XZAQa2PplVoPcM+hBor
 NnJM3+vnQLksMI9+GLsTQyShAt9vinMwzyherXhD3Z6yZougZJDb5MGswuOIYQPTaLnp
 eOwpD3RK6UKzHEBhdtuuBicCxlOQAKzRt+UjK47DU6IfTUoBx8dRwLlIOnv03iXsVo1r
 HIiYIFd5JmeZ5GSjFnhZMnFBprk+6rHYt0muvL4D3kD8wxS3SDBtlQrbzRz3/OLTPcE0
 jGzxzDzrbk3ajutjqyqni0Gp5+f95GxbwwTUk9dZB8iFzoAa+gjRHLwYKZ/wW+Fec/vW Kg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 322kv6cya6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 07 Jul 2020 15:13:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 067F95Oq085644;
        Tue, 7 Jul 2020 15:11:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 324n4rb2cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jul 2020 15:11:34 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 067FBV1q006188;
        Tue, 7 Jul 2020 15:11:31 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jul 2020 08:11:30 -0700
Date:   Tue, 7 Jul 2020 18:11:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     kbuild@lists.01.org,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>, lkp@intel.com,
        kbuild-all@lists.01.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Rich Felker <dalias@libc.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Hanjun Guo <guohanjun@huawei.com>,
        "open list:REMOTE PROCESSOR REMOTEPROC SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>
Subject: Re: [PATCH v6 08/12] device core: Introduce DMA range map,
 supplanting dma_pfn_offset
Message-ID: <20200707151122.GX2571@kadam>
References: <20200701212155.37830-9-james.quinlan@broadcom.com>
 <20200707132724.GT2549@kadam>
 <CA+-6iNwzQ0gn2KfdqNGwGjDgPT5op8bTCs6paMT7BwVmm+9vTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNwzQ0gn2KfdqNGwGjDgPT5op8bTCs6paMT7BwVmm+9vTw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9675 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9675 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070113
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Sorry for the noise.  Your code is correct.  I'm not 100% sure what went
wrong.  Either the cross function database wasn't built or there is a
bug in the published code that is fixed on my private Smatch build.  I
will investigate.

regards,
dan carpenter

