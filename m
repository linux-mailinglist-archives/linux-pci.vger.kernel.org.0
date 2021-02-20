Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBAA32063B
	for <lists+linux-pci@lfdr.de>; Sat, 20 Feb 2021 17:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhBTQea (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 20 Feb 2021 11:34:30 -0500
Received: from mga07.intel.com ([134.134.136.100]:49624 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229871AbhBTQe2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 20 Feb 2021 11:34:28 -0500
IronPort-SDR: nbw0B8AwgS98nuupm9RYH2oe+/aggpEuPNtz49TQazCH2TMCmgVTPs9/UdEBkSlrTmeP8Ldr/2
 eUtqJqp8gx3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9901"; a="248166570"
X-IronPort-AV: E=Sophos;i="5.81,193,1610438400"; 
   d="scan'208";a="248166570"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 08:33:45 -0800
IronPort-SDR: HCmfnr4BFvfkIsrMlOz26nZFz60eFrZkpzp+8aso+hjQSnAOdAEixQnxHfrxtY+96fnx6Du/in
 +adw/bEQtbxQ==
X-IronPort-AV: E=Sophos;i="5.81,193,1610438400"; 
   d="scan'208";a="582068409"
Received: from aevangel-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.134.76])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2021 08:33:46 -0800
Date:   Sat, 20 Feb 2021 08:33:44 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v5 4/9] cxl/mem: Add basic IOCTL interface
Message-ID: <20210220163344.csczmkyxkpu4fxah@intel.com>
References: <20210217040958.1354670-1-ben.widawsky@intel.com>
 <20210217040958.1354670-5-ben.widawsky@intel.com>
 <YDBkOB3K8UqVakFf@Konrads-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDBkOB3K8UqVakFf@Konrads-MacBook-Pro.local>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-02-19 20:22:00, Konrad Rzeszutek Wilk wrote:
> ..snip..
> > +static int handle_mailbox_cmd_from_user(struct cxl_mem *cxlm,
> > +					const struct cxl_mem_command *cmd,
> > +					u64 in_payload, u64 out_payload,
> > +					s32 *size_out, u32 *retval)
> > +{
> > +	struct device *dev = &cxlm->pdev->dev;
> > +	struct mbox_cmd mbox_cmd = {
> > +		.opcode = cmd->opcode,
> > +		.size_in = cmd->info.size_in,
> > +		.size_out = cmd->info.size_out,
> > +	};
> > +	int rc;
> > +
> > +	if (cmd->info.size_out) {
> > +		mbox_cmd.payload_out = kvzalloc(cmd->info.size_out, GFP_KERNEL);
> > +		if (!mbox_cmd.payload_out)
> > +			return -ENOMEM;
> > +	}
> > +
> > +	if (cmd->info.size_in) {
> > +		mbox_cmd.payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
> > +						   cmd->info.size_in);
> > +		if (IS_ERR(mbox_cmd.payload_in))
> > +			return PTR_ERR(mbox_cmd.payload_in);
> 
> Not that this should happen, but what if info.size_out was set? Should
> you also free mbox_cmd.payload_out?
> 

Thanks Konrad.

Dan, do you want me to send a fixup patch? This bug was introduced from v4->v5.

> > +	}
> > +
> > +	rc = cxl_mem_mbox_get(cxlm);
> > +	if (rc)
> > +		goto out;
> > +
> > +	dev_dbg(dev,
> > +		"Submitting %s command for user\n"
> > +		"\topcode: %x\n"
> > +		"\tsize: %ub\n",
> > +		cxl_command_names[cmd->info.id].name, mbox_cmd.opcode,
> > +		cmd->info.size_in);
> > +
> > +	rc = __cxl_mem_mbox_send_cmd(cxlm, &mbox_cmd);
> > +	cxl_mem_mbox_put(cxlm);
> > +	if (rc)
> > +		goto out;
> > +
> > +	/*
> > +	 * @size_out contains the max size that's allowed to be written back out
> > +	 * to userspace. While the payload may have written more output than
> > +	 * this it will have to be ignored.
> > +	 */
> > +	if (mbox_cmd.size_out) {
> > +		dev_WARN_ONCE(dev, mbox_cmd.size_out > *size_out,
> > +			      "Invalid return size\n");
> > +		if (copy_to_user(u64_to_user_ptr(out_payload),
> > +				 mbox_cmd.payload_out, mbox_cmd.size_out)) {
> > +			rc = -EFAULT;
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	*size_out = mbox_cmd.size_out;
> > +	*retval = mbox_cmd.return_code;
> > +
> > +out:
> > +	kvfree(mbox_cmd.payload_in);
> > +	kvfree(mbox_cmd.payload_out);
> > +	return rc;
> > +}
> 
> ..snip..
> 
> > +static int cxl_query_cmd(struct cxl_memdev *cxlmd,
> > +			 struct cxl_mem_query_commands __user *q)
> > +{
> > +	struct device *dev = &cxlmd->dev;
> > +	struct cxl_mem_command *cmd;
> > +	u32 n_commands;
> > +	int j = 0;
> 
> How come it is 'j' instead of the usual 'i'?

Just how it got split out/copied from an earlier version of the series.

I think rename to i, or cmds would be best as well. I/Dan can do it as part of
the bug fix you found above.

> > +
> > +	dev_dbg(dev, "Query IOCTL\n");
> > +
> > +	if (get_user(n_commands, &q->n_commands))
> > +		return -EFAULT;
> > +
> > +	/* returns the total number if 0 elements are requested. */
> > +	if (n_commands == 0)
> > +		return put_user(cxl_cmd_count, &q->n_commands);
> > +
> > +	/*
> > +	 * otherwise, return max(n_commands, total commands) cxl_command_info
> > +	 * structures.
> > +	 */
> > +	cxl_for_each_cmd(cmd) {
> > +		const struct cxl_command_info *info = &cmd->info;
> > +
> > +		if (copy_to_user(&q->commands[j++], info, sizeof(*info)))
> > +			return -EFAULT;
> > +
> > +		if (j == n_commands)
> > +			break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
