Return-Path: <linux-pci+bounces-3858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4568485F667
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 12:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBF3287707
	for <lists+linux-pci@lfdr.de>; Thu, 22 Feb 2024 11:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ECC3FB39;
	Thu, 22 Feb 2024 11:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5Z6LsFt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550513FB31;
	Thu, 22 Feb 2024 11:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599737; cv=none; b=q+6K7psSzIa8RTfMciC6gCFKaabnhDjdeyH4PLZNd261iIz9GmyQTfG33DAT+pLMb57nwZjclWs9Fv3XHsS33MVG7/AZCOx6tV5YxgqsF2gTLpAfEJADZZSLlAhrADqsn2g9UEWPGVKRYzg2vdnDBU8K7BXLaIGOs1kQGu3Npo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599737; c=relaxed/simple;
	bh=OVOk4RhIEc0k7TSecJD8kDaA2nGJ6pApQKcMqlr9SD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfX8+lnY4RnTFF2WfhuRoNinQTSxjehl+jKirD4BvMM4PEQOD+jos6wmXoWDnj6poMsR1aSJL5nN6s++uka/jN5KlMN55aoQNkZ91JpsWgyqQbO85mhh1B0KmjhwL4ADKR6QORLlqEtO8zrc6cS6yTGoHveD6LRnDqhon3mRhL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5Z6LsFt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708599735; x=1740135735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OVOk4RhIEc0k7TSecJD8kDaA2nGJ6pApQKcMqlr9SD0=;
  b=V5Z6LsFtGtjQy/V5Jd7gz/hOdla/lZwerTYf12W8hvBNdoFtml0NHv4P
   B2EEoQPlqGC7dly/haG+jasgjSHjhd8PzJ9bKEgJGG1Z41sfbb+pmG/sx
   j+qqQNDpyhtbwFHI1eeXcUQ6G1eKwHd6oeAxNKS7o83LgkLB/xe3eQS0O
   uVdbqraGatLLCwmbIKqiz2/iwqxOO2csZ8+Goyvc21YrH1My+Nvw0EyfL
   d9/Ndr3c+2Vq7ynqqnpx8Ta+AyZsIDMP1/8pWgiVZPXS2gm3EWIwiDAjg
   3JPnMOoYYR9t+i9ZiGY8MBLQxA96OG3pl04NtLqZsXjOQYTpKjfDKkIaY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2957367"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2957367"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 03:02:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="36472291"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 22 Feb 2024 03:02:09 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rd6q6-0006Ei-2E;
	Thu, 22 Feb 2024 11:02:06 +0000
Date: Thu, 22 Feb 2024 19:01:22 +0800
From: kernel test robot <lkp@intel.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org,
	conor+dt@kernel.org, quic_nitegupt@quicinc.com
Cc: oe-kbuild-all@lists.linux.dev, quic_shazhuss@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
	Nitesh Gupta <nitegupt@quicinc.com>,
	Mrinmay Sarkar <quic_msarkar@quicinc.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] PCI: qcom: Add support for detecting controller
 level PCIe errors
Message-ID: <202402221838.5n7vo0Jo-lkp@intel.com>
References: <20240221140405.28532-4-root@hu-msarkar-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221140405.28532-4-root@hu-msarkar-hyd.qualcomm.com>

Hi root,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus robh/for-next mani-mhi/mhi-next linus/master v6.8-rc5 next-20240221]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/root/dt-bindings-PCI-qcom-Add-global-irq-support-for-SA8775p/20240221-220722
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20240221140405.28532-4-root%40hu-msarkar-hyd.qualcomm.com
patch subject: [PATCH v1 3/3] PCI: qcom: Add support for detecting controller level PCIe errors
config: microblaze-allmodconfig (https://download.01.org/0day-ci/archive/20240222/202402221838.5n7vo0Jo-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240222/202402221838.5n7vo0Jo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402221838.5n7vo0Jo-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-qcom.c: In function 'qcom_pcie_error_report_show':
>> drivers/pci/controller/dwc/pcie-qcom.c:1751:63: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'u32' {aka 'unsigned int'} [-Wformat=]
    1751 |                         len += sysfs_emit_at(buf, len, "%s: %lu\n",
         |                                                             ~~^
         |                                                               |
         |                                                               long unsigned int
         |                                                             %u
    1752 |                                         pcie_fault_string[i],
    1753 |                                         pcie_fault[i]);
         |                                         ~~~~~~~~~~~~~          
         |                                                   |
         |                                                   u32 {aka unsigned int}
   drivers/pci/controller/dwc/pcie-qcom.c:1756:47: warning: format '%lu' expects argument of type 'long unsigned int', but argument 5 has type 'u32' {aka 'unsigned int'} [-Wformat=]
    1756 |         len += sysfs_emit_at(buf, len, "%s: %lu\n",
         |                                             ~~^
         |                                               |
         |                                               long unsigned int
         |                                             %u
    1757 |                                         pcie_fault_string[i],
    1758 |                                         pcie->pcie_fault_total);
         |                                         ~~~~~~~~~~~~~~~~~~~~~~
         |                                             |
         |                                             u32 {aka unsigned int}
   drivers/pci/controller/dwc/pcie-qcom.c: In function 'qcom_pcie_probe':
>> drivers/pci/controller/dwc/pcie-qcom.c:1902:9: warning: ignoring return value of 'sysfs_create_group' declared with attribute 'warn_unused_result' [-Wunused-result]
    1902 |         sysfs_create_group(&pdev->dev.kobj, &qcom_pcie_attribute_group);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +1751 drivers/pci/controller/dwc/pcie-qcom.c

  1739	
  1740	static ssize_t qcom_pcie_error_report_show(struct device *dev,
  1741			struct device_attribute *attr,
  1742			char *buf)
  1743	{
  1744		unsigned int i;
  1745		struct qcom_pcie *pcie = (struct qcom_pcie *)dev_get_drvdata(dev);
  1746		u32 *pcie_fault = pcie->pcie_fault;
  1747		size_t len = 0;
  1748	
  1749		for (i = 0; i < MAX_PCIE_SAFETY_FAULT; i++) {
  1750			if (pcie_fault_string[i])
> 1751				len += sysfs_emit_at(buf, len, "%s: %lu\n",
  1752						pcie_fault_string[i],
  1753						pcie_fault[i]);
  1754		}
  1755	
  1756		len += sysfs_emit_at(buf, len, "%s: %lu\n",
  1757						pcie_fault_string[i],
  1758						pcie->pcie_fault_total);
  1759	
  1760		return len;
  1761	}
  1762	static DEVICE_ATTR_RO(qcom_pcie_error_report);
  1763	
  1764	static struct attribute *qcom_pcie_attrs[] = {
  1765		&dev_attr_qcom_pcie_error_report.attr,
  1766		NULL,
  1767	};
  1768	
  1769	static const struct attribute_group qcom_pcie_attribute_group = {
  1770		.attrs = qcom_pcie_attrs,
  1771		.name = "qcom_pcie"
  1772	};
  1773	
  1774	static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
  1775	{
  1776		struct dw_pcie *pci = pcie->pci;
  1777		struct device *dev = pci->dev;
  1778		char *name;
  1779	
  1780		name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
  1781		if (!name)
  1782			return;
  1783	
  1784		pcie->debugfs = debugfs_create_dir(name, NULL);
  1785		debugfs_create_devm_seqfile(dev, "link_transition_count", pcie->debugfs,
  1786					    qcom_pcie_link_transition_count);
  1787	}
  1788	
  1789	static int qcom_pcie_probe(struct platform_device *pdev)
  1790	{
  1791		const struct qcom_pcie_cfg *pcie_cfg;
  1792		struct device *dev = &pdev->dev;
  1793		struct qcom_pcie *pcie;
  1794		struct dw_pcie_rp *pp;
  1795		struct resource *res;
  1796		struct dw_pcie *pci;
  1797		int ret;
  1798	
  1799		pcie_cfg = of_device_get_match_data(dev);
  1800		if (!pcie_cfg || !pcie_cfg->ops) {
  1801			dev_err(dev, "Invalid platform data\n");
  1802			return -EINVAL;
  1803		}
  1804	
  1805		pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
  1806		if (!pcie)
  1807			return -ENOMEM;
  1808	
  1809		pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
  1810		if (!pci)
  1811			return -ENOMEM;
  1812	
  1813		pm_runtime_enable(dev);
  1814		ret = pm_runtime_get_sync(dev);
  1815		if (ret < 0)
  1816			goto err_pm_runtime_put;
  1817	
  1818		pci->dev = dev;
  1819		pci->ops = &dw_pcie_ops;
  1820		pp = &pci->pp;
  1821	
  1822		pcie->pci = pci;
  1823	
  1824		pcie->cfg = pcie_cfg;
  1825	
  1826		pcie->reset = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
  1827		if (IS_ERR(pcie->reset)) {
  1828			ret = PTR_ERR(pcie->reset);
  1829			goto err_pm_runtime_put;
  1830		}
  1831	
  1832		pcie->global_irq = platform_get_irq_byname(pdev, "global");
  1833		if (pcie->global_irq < 0) {
  1834			ret = pcie->global_irq;
  1835			goto err_pm_runtime_put;
  1836		}
  1837	
  1838		ret = devm_request_threaded_irq(dev, pcie->global_irq, NULL,
  1839					qcom_pcie_global_irq_thread,
  1840					IRQF_ONESHOT,
  1841					"global_irq", pcie);
  1842		if (ret) {
  1843			dev_err(dev, "Failed to request Global IRQ\n");
  1844			goto err_pm_runtime_put;
  1845		}
  1846	
  1847		pcie->parf = devm_platform_ioremap_resource_byname(pdev, "parf");
  1848		if (IS_ERR(pcie->parf)) {
  1849			ret = PTR_ERR(pcie->parf);
  1850			goto err_pm_runtime_put;
  1851		}
  1852	
  1853		pcie->elbi = devm_platform_ioremap_resource_byname(pdev, "elbi");
  1854		if (IS_ERR(pcie->elbi)) {
  1855			ret = PTR_ERR(pcie->elbi);
  1856			goto err_pm_runtime_put;
  1857		}
  1858	
  1859		/* MHI region is optional */
  1860		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mhi");
  1861		if (res) {
  1862			pcie->mhi = devm_ioremap_resource(dev, res);
  1863			if (IS_ERR(pcie->mhi)) {
  1864				ret = PTR_ERR(pcie->mhi);
  1865				goto err_pm_runtime_put;
  1866			}
  1867		}
  1868	
  1869		pcie->phy = devm_phy_optional_get(dev, "pciephy");
  1870		if (IS_ERR(pcie->phy)) {
  1871			ret = PTR_ERR(pcie->phy);
  1872			goto err_pm_runtime_put;
  1873		}
  1874	
  1875		ret = qcom_pcie_icc_init(pcie);
  1876		if (ret)
  1877			goto err_pm_runtime_put;
  1878	
  1879		ret = pcie->cfg->ops->get_resources(pcie);
  1880		if (ret)
  1881			goto err_pm_runtime_put;
  1882	
  1883		pp->ops = &qcom_pcie_dw_ops;
  1884	
  1885		ret = phy_init(pcie->phy);
  1886		if (ret)
  1887			goto err_pm_runtime_put;
  1888	
  1889		platform_set_drvdata(pdev, pcie);
  1890	
  1891		ret = dw_pcie_host_init(pp);
  1892		if (ret) {
  1893			dev_err(dev, "cannot initialize host\n");
  1894			goto err_phy_exit;
  1895		}
  1896	
  1897		qcom_pcie_icc_update(pcie);
  1898	
  1899		if (pcie->mhi)
  1900			qcom_pcie_init_debugfs(pcie);
  1901	
> 1902		sysfs_create_group(&pdev->dev.kobj, &qcom_pcie_attribute_group);
  1903	
  1904		return 0;
  1905	
  1906	err_phy_exit:
  1907		phy_exit(pcie->phy);
  1908	err_pm_runtime_put:
  1909		pm_runtime_put(dev);
  1910		pm_runtime_disable(dev);
  1911	
  1912		return ret;
  1913	}
  1914	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

