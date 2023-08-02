Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA7576C4AE
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 07:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjHBFPR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 01:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjHBFPP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 01:15:15 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81841736;
        Tue,  1 Aug 2023 22:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690953314; x=1722489314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fc2nysuFO9M8VGq9+Fl/1ckOPG9IPmlUO6abXeCqJyk=;
  b=mYV8sy74yDlu0uAzR1G3yPxHuvkAlEUOefrazmWNKda+88I7KoRYDGcz
   3H4n7v0Ezof+2h9ccnInqryCO+Cn6BrUZhoLV4iz0PqjmZG8AKaANS+Vx
   gAtMg5M5vYiyZg5AjBYdc/jty0L+DyEEQE2BJbNNZmT0MZBmYPowssbOS
   u2mFBi+3eSNc7QsyUNLqWBoIRxdMubfkfBD6YzsiImNhZ/7rtoaxOWe4d
   IR5fPqacEk99gmQVRoQ8x4EvOSSRoflXwNr5aRjWjPazfNVAv9xxoCTOZ
   pZUTLf+k37sDGNarvCJPhd+H6lxl8I0R1D+Rp07VIwsjCw7Ny/+qCLlp3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="369480283"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="369480283"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 22:15:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="764064754"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="764064754"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Aug 2023 22:15:09 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qR4CS-0000tB-2d;
        Wed, 02 Aug 2023 05:15:08 +0000
Date:   Wed, 2 Aug 2023 13:14:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 1/4] PCI: endpoint: Add D-state change notifier support
Message-ID: <202308021312.obgu7FWM-lkp@intel.com>
References: <1690948281-2143-2-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690948281-2143-2-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krishna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.5-rc4 next-20230801]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/PCI-endpoint-Add-D-state-change-notifier-support/20230802-115309
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/1690948281-2143-2-git-send-email-quic_krichai%40quicinc.com
patch subject: [PATCH v5 1/4] PCI: endpoint: Add D-state change notifier support
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20230802/202308021312.obgu7FWM-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230802/202308021312.obgu7FWM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308021312.obgu7FWM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/endpoint/pci-epc-core.c:795:6: warning: no previous prototype for 'pci_epc_dstate_notity' [-Wmissing-prototypes]
     795 | void pci_epc_dstate_notity(struct pci_epc *epc, pci_power_t state)
         |      ^~~~~~~~~~~~~~~~~~~~~


vim +/pci_epc_dstate_notity +795 drivers/pci/endpoint/pci-epc-core.c

   785	
   786	/**
   787	 * pci_epc_dstate_notity() - Notify the EPF driver that EPC device D-state
   788	 *			has changed
   789	 * @epc: the EPC device which has change in D-state
   790	 * @state: the changed D-state
   791	 *
   792	 * Invoke to Notify the EPF device that the EPC device has D-state has
   793	 * changed.
   794	 */
 > 795	void pci_epc_dstate_notity(struct pci_epc *epc, pci_power_t state)
   796	{
   797		struct pci_epf *epf;
   798	
   799		if (!epc || IS_ERR(epc))
   800			return;
   801	
   802		mutex_lock(&epc->list_lock);
   803		list_for_each_entry(epf, &epc->pci_epf, list) {
   804			mutex_lock(&epf->lock);
   805			if (epf->event_ops && epf->event_ops->dstate_notify)
   806				epf->event_ops->dstate_notify(epf, state);
   807			mutex_unlock(&epf->lock);
   808		}
   809		mutex_unlock(&epc->list_lock);
   810	}
   811	EXPORT_SYMBOL_GPL(pci_epc_dstate_notity);
   812	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
