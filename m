Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 693443555BC
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 15:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhDFNvb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 09:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238092AbhDFNva (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 09:51:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15C6261246;
        Tue,  6 Apr 2021 13:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617717081;
        bh=0cEF+ZfK0qQzRjxEveUnWvJ66nuEubWDvgk4DN5Y7rE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o7mKzgsjZvW55vGPgOaKm1aH/fgmq+BX6u52nCrk6NLVU/4AYpo7We6Pt/XyePltz
         8QuFSEnF2ZUbLnRVxiQZUt7+hOBPsDN4svxCb4MIIVjIIs2A7c+YaGQsAIEKr+jE9p
         y3i9ApZjD/3jHc0qj10BvoH8xSvuv64AjS+8ja7I=
Date:   Tue, 6 Apr 2021 15:51:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     alexander.shishkin@linux.intel.com, helgaas@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, jonathan.cameron@huawei.com,
        song.bao.hua@hisilicon.com, prime.zeng@huawei.com,
        linux-doc@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH 1/4] hwtracing: Add trace function support for HiSilicon
 PCIe Tune and Trace device
Message-ID: <YGxnV163z9ptAN0B@kroah.com>
References: <1617713154-35533-1-git-send-email-yangyicong@hisilicon.com>
 <1617713154-35533-2-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617713154-35533-2-git-send-email-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 06, 2021 at 08:45:51PM +0800, Yicong Yang wrote:
> +static int hisi_ptt_create_trace_entries(struct hisi_ptt *hisi_ptt)
> +{
> +	struct hisi_ptt_debugfs_file_desc *trace_files;
> +	struct dentry *dir;
> +	int i, ret = 0;
> +
> +	dir = debugfs_create_dir("trace", hisi_ptt->debugfs_dir);
> +	if (IS_ERR(dir))
> +		return PTR_ERR(dir);

No need to care about this, please do not check, code should not do
different things based on if debugfs is working or not.

> +
> +	trace_files = devm_kmemdup(&hisi_ptt->pdev->dev, trace_entries,
> +				   sizeof(trace_entries), GFP_KERNEL);
> +	if (IS_ERR(trace_files)) {
> +		ret = PTR_ERR(trace_files);
> +		goto err;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(trace_entries); ++i) {
> +		struct dentry *file;
> +
> +		trace_files[i].hisi_ptt = hisi_ptt;
> +		file = debugfs_create_file(trace_files[i].name, 0600,
> +					   dir, &trace_files[i],
> +					   trace_files[i].fops);
> +		if (IS_ERR(file)) {
> +			ret = PTR_ERR(file);

Same here, why check?

> +static int hisi_ptt_register_debugfs(void)
> +{
> +	if (!debugfs_initialized()) {
> +		pr_err("failed to create debugfs directory: debugfs uninitialized\n");

Why do you care?  How can this happen?

> +		return -ENOENT;
> +	}
> +
> +	hisi_ptt_debugfs_root = debugfs_create_dir("hisi_ptt", NULL);
> +	if (IS_ERR(hisi_ptt_debugfs_root)) {

Again, no need to check.

If you are building the whole functionality of your code on if debugfs
is working or not, that feels really wrong.  Debugfs is for random
kernel debug type things, not a whole driver infrastructure that somehow
relies on it working or not.

thanks,

greg k-h
