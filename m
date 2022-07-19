Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A3B57A1A4
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 16:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbiGSOeE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 10:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239025AbiGSOdw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 10:33:52 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321C35597;
        Tue, 19 Jul 2022 07:24:10 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LnLdF5GkTz681Yv;
        Tue, 19 Jul 2022 22:22:25 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 16:24:08 +0200
Received: from localhost (10.81.209.49) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 15:24:07 +0100
Date:   Tue, 19 Jul 2022 15:24:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <david@redhat.com>, <gregkh@linuxfoundation.org>, <jgg@nvidia.com>
Subject: Re: [PATCH 09/46] cxl/acpi: Track CXL resources in iomem_resource
Message-ID: <20220719152405.00005973@Huawei.com>
In-Reply-To: <62ca358c461f1_2da5bd294fa@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603876550.551046.11015869763159096807.stgit@dwillia2-xfh>
        <20220628174346.00005dcc@Huawei.com>
        <62ca358c461f1_2da5bd294fa@dwillia2-xfh.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.209.49]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> Added the following...
> 
> /**
>  * add_cxl_resources() - reflect CXL fixed memory windows in iomem_resource
>  * @cxl_res: A standalone resource tree where each CXL window is a sibling
>  *
>  * Walk each CXL window in @cxl_res and add it to iomem_resource potentially
>  * expanding its boundaries to ensure that any conflicting resources become
>  * children. If a window is expanded it may then conflict with a another window
>  * entry and require the window to be truncated or trimmed. Consider this
>  * situation:
>  *
>  * |-- "CXL Window 0" --||----- "CXL Window 1" -----|
>  * |--------------- "System RAM" -------------|
>  *
>  * ...where platform firmware has established as System RAM resource across 2
>  * windows, but has left some portion of window 1 for dynamic CXL region
>  * provisioning. In this case "Window 0" will span the entirety of the "System
>  * RAM" span, and "CXL Window 1" is truncated to the remaining tail past the end
>  * of that "System RAM" resource.
>  */

Very nice.  Thanks!

J
