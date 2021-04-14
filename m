Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D24F35F411
	for <lists+linux-pci@lfdr.de>; Wed, 14 Apr 2021 14:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347376AbhDNMjp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Apr 2021 08:39:45 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2855 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347201AbhDNMjl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Apr 2021 08:39:41 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FL22x4pRgz68B8f;
        Wed, 14 Apr 2021 20:34:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 14 Apr 2021 14:39:18 +0200
Received: from localhost (10.52.122.47) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Wed, 14 Apr
 2021 13:39:17 +0100
Date:   Wed, 14 Apr 2021 13:37:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/mem: Clarify UAPI documentation
Message-ID: <20210414133750.000042b1@Huawei.com>
In-Reply-To: <20210413143247.546256-1-ben.widawsky@intel.com>
References: <20210413143247.546256-1-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.47]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 13 Apr 2021 07:32:47 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Sensible update.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  include/uapi/linux/cxl_mem.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index f6e8a005b113..8dd516ddb098 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -81,6 +81,13 @@ static const struct {
>   *  - @size_in = -1
>   *  - @size_out = 0
>   *
> + * Commands which have a variable length input likely have a minimum length.
> + * This is not enforced by the UAPI, and therefore might look like the command
> + * succeeded when sending too small of an input payload. Caution should be taken
> + * by checking the @cxl_send_command.retval for such cases. For commands with a
> + * variable length output, the caller is free to consume as little or as much as
> + * they want.
> + *
>   * See struct cxl_mem_query_commands.
>   */
>  struct cxl_command_info {

