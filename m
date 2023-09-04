Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD7F791154
	for <lists+linux-pci@lfdr.de>; Mon,  4 Sep 2023 08:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbjIDG1Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Sep 2023 02:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjIDG1X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Sep 2023 02:27:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E8CD9;
        Sun,  3 Sep 2023 23:27:20 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38465Tbm015376;
        Mon, 4 Sep 2023 06:27:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TcGh+Lhn98VQXuDAoukbvJGKrYGtJI1AhwTAqTtLlNU=;
 b=Csac/OXw/VoF7ZxwHdNV9b1URYfGuXwxuFfg45umW7a2n4nMoawaduwk2ddijNuWnjrU
 0jwxNhCUXyvrEDjPIfJdVYp8uxMzk4RpyprwTFt0rDVN3G1uL7dv2zH3IOoWt03cT0o9
 GZEaUsi7TeSZLgcTgqlJKDgNtJMXuiUTWgENjg3tt3+Mj81lYA7ZJ1aHTvs4LhgX1Pis
 2tolQQ0YvlY7ykvFZxYnFSY8tXI9vSd8h8h1BkfuREtlB43kzJ1VQt0e0Ud96n4ChqO4
 hoL6a4KM9+zMJmQ33cWrF2rE2QBrhqfFskjtXIsXeGJyYQEkg7wHss3R4fz4fPlYe/pd BA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3suvcrapbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 06:27:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3846R6NP028687
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Sep 2023 06:27:06 GMT
Received: from [10.216.27.210] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sun, 3 Sep
 2023 23:27:02 -0700
Message-ID: <fa5a20d0-77db-58bd-3956-ac664dffa587@quicinc.com>
Date:   Mon, 4 Sep 2023 11:56:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 00/10] Add PCIe Bandwidth Controller
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Alex Deucher <alexdeucher@gmail.com>
References: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HoBSEGKeJMUGimqfBjvLmF_3PS2UBD-Y
X-Proofpoint-ORIG-GUID: HoBSEGKeJMUGimqfBjvLmF_3PS2UBD-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_03,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=801 impostorscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1011 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040057
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 8/17/2023 5:46 PM, Ilpo Järvinen wrote:
> Hi all,
>
> This series adds PCIe bandwidth controller (bwctrl) and associated PCIe
> cooling driver to the thermal core side for limiting PCIe link speed
> due to thermal reasons. PCIe bandwidth controller is a PCI express bus
> port service driver. A cooling device is created for each port the
> service driver finds if they support changing speeds.

I see we had support for only link speed changes here but we need to add 
support for

link width change also as bandwidth notification from PCIe supports both 
link speed and link width.

- KC

>
> bwctrl now is built on top of BW notifications revert. I'm just not
> sure what is the best practice when re-adding some old functionality in
> a modified form so please let me know if I need to somehow alter that
> patch.
>
> The series is based on top of the RMW changes in pci/pcie-rmw.
>
> Ilpo Järvinen (10):
>    PCI: Protect Link Control 2 Register with RMW locking
>    drm/radeon: Use RMW accessors for changing LNKCTL2
>    drm/amdgpu: Use RMW accessors for changing LNKCTL2
>    drm/IB/hfi1: Use RMW accessors for changing LNKCTL2
>    PCI: Store all PCIe Supported Link Speeds
>    PCI: Cache PCIe device's Supported Speed Vector
>    PCI/LINK: Re-add BW notification portdrv as PCIe BW controller
>    PCI/bwctrl: Add "controller" part into PCIe bwctrl
>    thermal: Add PCIe cooling driver
>    selftests/pcie_bwctrl: Create selftests
>
>   MAINTAINERS                                   |   8 +
>   drivers/gpu/drm/amd/amdgpu/cik.c              |  41 +--
>   drivers/gpu/drm/amd/amdgpu/si.c               |  41 +--
>   drivers/gpu/drm/radeon/cik.c                  |  40 +--
>   drivers/gpu/drm/radeon/si.c                   |  40 +--
>   drivers/infiniband/hw/hfi1/pcie.c             |  30 +-
>   drivers/pci/pcie/Kconfig                      |   9 +
>   drivers/pci/pcie/Makefile                     |   1 +
>   drivers/pci/pcie/bwctrl.c                     | 309 ++++++++++++++++++
>   drivers/pci/pcie/portdrv.c                    |   9 +-
>   drivers/pci/pcie/portdrv.h                    |  10 +-
>   drivers/pci/probe.c                           |  38 ++-
>   drivers/pci/remove.c                          |   2 +
>   drivers/thermal/Kconfig                       |  10 +
>   drivers/thermal/Makefile                      |   2 +
>   drivers/thermal/pcie_cooling.c                | 107 ++++++
>   include/linux/pci-bwctrl.h                    |  33 ++
>   include/linux/pci.h                           |   3 +
>   include/uapi/linux/pci_regs.h                 |   1 +
>   tools/testing/selftests/Makefile              |   1 +
>   tools/testing/selftests/pcie_bwctrl/Makefile  |   2 +
>   .../pcie_bwctrl/set_pcie_cooling_state.sh     | 122 +++++++
>   .../selftests/pcie_bwctrl/set_pcie_speed.sh   |  67 ++++
>   23 files changed, 795 insertions(+), 131 deletions(-)
>   create mode 100644 drivers/pci/pcie/bwctrl.c
>   create mode 100644 drivers/thermal/pcie_cooling.c
>   create mode 100644 include/linux/pci-bwctrl.h
>   create mode 100644 tools/testing/selftests/pcie_bwctrl/Makefile
>   create mode 100755 tools/testing/selftests/pcie_bwctrl/set_pcie_cooling_state.sh
>   create mode 100755 tools/testing/selftests/pcie_bwctrl/set_pcie_speed.sh
>
