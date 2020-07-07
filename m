Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E81216DB4
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jul 2020 15:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgGGN2J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 09:28:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38634 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGN2J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jul 2020 09:28:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 067DLp1Q018218;
        Tue, 7 Jul 2020 13:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=a30YTHUoi3kAuYFCBdh32qCdMdkt5h1II+yVCg92p64=;
 b=OXjwyDRAzAurEE+RoteeNPbM0Im2QddUQXdn97dckCLPmP5wl9ZqtToG69Gkr+Nn2tND
 aPsXwxAMVYf+Tj73FOw0SObko/D18RrM1m/Ihk8KK1QzgwKfawF75sOmn+6tqCKphVIR
 gLmpqMy7xEF1zWITjKEJmH71cKGUk79Xhpm9LAPLK12T0Nv/Tmy5itLspD8wqW9alKpN
 ahKwckKbzSfR5AZniBTqrFThFrmJWD6rONgdab90NxcXMDDggWdQx0oIXk/c0vqLS/fk
 PT9C3G4Lf9tTnj5TQ2JenmH7ECsbx6OTPcTh8Mu8yhz7KD/HOrSWE0SR8DMhbTrtjXox KA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 323wacg8bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 07 Jul 2020 13:27:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 067DN6vv128881;
        Tue, 7 Jul 2020 13:27:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 324n4r68b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jul 2020 13:27:37 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 067DRYeT000829;
        Tue, 7 Jul 2020 13:27:34 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jul 2020 06:27:32 -0700
Date:   Tue, 7 Jul 2020 16:27:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jim Quinlan <james.quinlan@broadcom.com>,
        linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rich Felker <dalias@libc.org>,
        "open list:SUPERH" <linux-sh@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Hanjun Guo <guohanjun@huawei.com>,
        "open list:REMOTE PROCESSOR REMOTEPROC SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>
Subject: Re: [PATCH v6 08/12] device core: Introduce DMA range map,
 supplanting dma_pfn_offset
Message-ID: <20200707132724.GT2549@kadam>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8N0TQpGUCeEQshoq"
Content-Disposition: inline
In-Reply-To: <20200701212155.37830-9-james.quinlan@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9674 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0 cotscore=-2147483648
 suspectscore=0 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070101
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--8N0TQpGUCeEQshoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jim,

url:    https://github.com/0day-ci/linux/commits/Jim-Quinlan/PCI-brcmstb-enable-PCIe-for-STB-chips/20200702-053156
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: arm-randconfig-m031-20200701 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/of/address.c:1012 of_dma_get_range() warn: passing zero to 'ERR_PTR'

# https://github.com/0day-ci/linux/commit/0c50b6db383883854419f10df0d79b663433f121
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 0c50b6db383883854419f10df0d79b663433f121
vim +/ERR_PTR +1012 drivers/of/address.c

18308c94723e16 Grygorii Strashko 2014-04-24   955  /**
0c50b6db383883 Jim Quinlan       2020-07-01   956   * of_dma_get_range - Get DMA range info and put it into a map array
18308c94723e16 Grygorii Strashko 2014-04-24   957   * @np:		device node to get DMA range info
18308c94723e16 Grygorii Strashko 2014-04-24   958   *
18308c94723e16 Grygorii Strashko 2014-04-24   959   * Look in bottom up direction for the first "dma-ranges" property
0c50b6db383883 Jim Quinlan       2020-07-01   960   * and parse it.  Put the information into a DMA offset map array.
0c50b6db383883 Jim Quinlan       2020-07-01   961   *
18308c94723e16 Grygorii Strashko 2014-04-24   962   * dma-ranges format:
18308c94723e16 Grygorii Strashko 2014-04-24   963   *	DMA addr (dma_addr)	: naddr cells
18308c94723e16 Grygorii Strashko 2014-04-24   964   *	CPU addr (phys_addr_t)	: pna cells
18308c94723e16 Grygorii Strashko 2014-04-24   965   *	size			: nsize cells
18308c94723e16 Grygorii Strashko 2014-04-24   966   *
0c50b6db383883 Jim Quinlan       2020-07-01   967   * It returns -ENODEV if "dma-ranges" property was not found for this
0c50b6db383883 Jim Quinlan       2020-07-01   968   * device in the DT.
18308c94723e16 Grygorii Strashko 2014-04-24   969   */
0c50b6db383883 Jim Quinlan       2020-07-01   970  const struct bus_dma_region *of_dma_get_range(struct device_node *np)
18308c94723e16 Grygorii Strashko 2014-04-24   971  {
0c50b6db383883 Jim Quinlan       2020-07-01   972  	const struct bus_dma_region *map = NULL;
18308c94723e16 Grygorii Strashko 2014-04-24   973  	struct device_node *node = of_node_get(np);
0c50b6db383883 Jim Quinlan       2020-07-01   974  	struct of_range_parser parser;
18308c94723e16 Grygorii Strashko 2014-04-24   975  	const __be32 *ranges = NULL;
951d48855d86e7 Robin Murphy      2019-07-03   976  	bool found_dma_ranges = false;
7a8b64d17e3581 Rob Herring       2020-02-06   977  	struct of_range range;
0c50b6db383883 Jim Quinlan       2020-07-01   978  	int len, num_ranges = 0;
0c50b6db383883 Jim Quinlan       2020-07-01   979  	int ret = 0;
18308c94723e16 Grygorii Strashko 2014-04-24   980  
951d48855d86e7 Robin Murphy      2019-07-03   981  	while (node) {
18308c94723e16 Grygorii Strashko 2014-04-24   982  		ranges = of_get_property(node, "dma-ranges", &len);
18308c94723e16 Grygorii Strashko 2014-04-24   983  
18308c94723e16 Grygorii Strashko 2014-04-24   984  		/* Ignore empty ranges, they imply no translation required */
18308c94723e16 Grygorii Strashko 2014-04-24   985  		if (ranges && len > 0)
18308c94723e16 Grygorii Strashko 2014-04-24   986  			break;
18308c94723e16 Grygorii Strashko 2014-04-24   987  
951d48855d86e7 Robin Murphy      2019-07-03   988  		/* Once we find 'dma-ranges', then a missing one is an error */
951d48855d86e7 Robin Murphy      2019-07-03   989  		if (found_dma_ranges && !ranges) {
951d48855d86e7 Robin Murphy      2019-07-03   990  			ret = -ENODEV;
951d48855d86e7 Robin Murphy      2019-07-03   991  			goto out;
18308c94723e16 Grygorii Strashko 2014-04-24   992  		}
951d48855d86e7 Robin Murphy      2019-07-03   993  		found_dma_ranges = true;
18308c94723e16 Grygorii Strashko 2014-04-24   994  
951d48855d86e7 Robin Murphy      2019-07-03   995  		node = of_get_next_dma_parent(node);
951d48855d86e7 Robin Murphy      2019-07-03   996  	}
951d48855d86e7 Robin Murphy      2019-07-03   997  
951d48855d86e7 Robin Murphy      2019-07-03   998  	if (!node || !ranges) {
0d638a07d3a1e9 Rob Herring       2017-06-01   999  		pr_debug("no dma-ranges found for node(%pOF)\n", np);
18308c94723e16 Grygorii Strashko 2014-04-24  1000  		ret = -ENODEV;
18308c94723e16 Grygorii Strashko 2014-04-24  1001  		goto out;
18308c94723e16 Grygorii Strashko 2014-04-24  1002  	}
18308c94723e16 Grygorii Strashko 2014-04-24  1003  
7a8b64d17e3581 Rob Herring       2020-02-06  1004  	of_dma_range_parser_init(&parser, node);
7a8b64d17e3581 Rob Herring       2020-02-06  1005  
0c50b6db383883 Jim Quinlan       2020-07-01  1006  	for_each_of_range(&parser, &range)
0c50b6db383883 Jim Quinlan       2020-07-01  1007  		num_ranges++;
18308c94723e16 Grygorii Strashko 2014-04-24  1008  
0c50b6db383883 Jim Quinlan       2020-07-01  1009  	map = dma_create_offset_map(node, num_ranges);
                                                        ^^^
If this fails then "ret" is zero so the function returns NULL instead of
an error pointer.

18308c94723e16 Grygorii Strashko 2014-04-24  1010  out:
18308c94723e16 Grygorii Strashko 2014-04-24  1011  	of_node_put(node);
0c50b6db383883 Jim Quinlan       2020-07-01 @1012  	return map ? map : ERR_PTR(ret);
92ea637edea36e Santosh Shilimkar 2014-04-24  1014  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--8N0TQpGUCeEQshoq
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--8N0TQpGUCeEQshoq--
