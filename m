Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163194FF111
	for <lists+linux-pci@lfdr.de>; Wed, 13 Apr 2022 09:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbiDMH6b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Apr 2022 03:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiDMH63 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Apr 2022 03:58:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C079F4DF76;
        Wed, 13 Apr 2022 00:55:59 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23D6g8IP032500;
        Wed, 13 Apr 2022 07:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=SflzMpuDOSgixuneJO3qtDBdroKkxk0KE1SzPQKjkLI=;
 b=PnU+rLOuwXNzCdAmp0CJnQNDf7VxEQca5vanLnCaYXJxQfT4dWdM16U6mnQ0IStcAR6I
 qE4Ugis3OmWB9RUdkCd+7xC1rr+sMWEi7Sc9KPQtYKb4noYI4G61DURqm7bCRmRgrk2i
 l/kkAqepjS0DykxHijeQ6ePCcQn+dWuczynvNUJ+OUp6qjy56DLqtX6VJroPUfXmnJ9M
 fVPIklvE6+w2b8w5ryVaEfIFljZLRheSCXPUq06NvGqr9RmgR3PgcoZbxD3fbCN8JjLs
 v+5PNQhQdf8KtDrOpprbNry3sMQMUJQlUJeCM7vPW8tLXVYG6/PdlajiSD7EaWTqfEyN ng== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fdsfphbsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 07:55:51 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23D7q89s000488;
        Wed, 13 Apr 2022 07:55:49 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3fb1s8xb0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Apr 2022 07:55:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23D7ttLQ37093674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 07:55:55 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9872042041;
        Wed, 13 Apr 2022 07:55:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A2534203F;
        Wed, 13 Apr 2022 07:55:46 +0000 (GMT)
Received: from sig-9-145-36-41.uk.ibm.com (unknown [9.145.36.41])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Apr 2022 07:55:46 +0000 (GMT)
Message-ID: <817683ba1c0f0f246701e91395063b3eaf69cbbe.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/4] PCI: Move jailhouse's isolated function handling
 to pci_scan_slot()
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     kernel test robot <lkp@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org
Date:   Wed, 13 Apr 2022 09:55:45 +0200
In-Reply-To: <202204130045.AeSigvk8-lkp@intel.com>
References: <20220412143040.1882096-3-schnelle@linux.ibm.com>
         <202204130045.AeSigvk8-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PYZ-5W9NCscmk5iBPeGnna_mQr8O2JTA
X-Proofpoint-GUID: PYZ-5W9NCscmk5iBPeGnna_mQr8O2JTA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_08,2022-04-12_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2204130042
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 2022-04-13 at 00:28 +0800, kernel test robot wrote:
> Hi Niklas,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on helgaas-pci/next]
> [also build test WARNING on s390/features tip/x86/core v5.18-rc2 next-20220412]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Niklas-Schnelle/PCI-Rework-pci_scan_slot-and-isolated-PCI-functions/20220412-223307
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
> config: alpha-defconfig (https://download.01.org/0day-ci/archive/20220413/202204130045.AeSigvk8-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/5cac6729750b7434ff5d6ae99469e9e54bc9fb6e
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Niklas-Schnelle/PCI-Rework-pci_scan_slot-and-isolated-PCI-functions/20220412-223307
>         git checkout 5cac6729750b7434ff5d6ae99469e9e54bc9fb6e
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/pci/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/pci/probe.c: In function 'pci_scan_child_bus_extend':
> > > drivers/pci/probe.c:2861:13: warning: variable 'nr_devs' set but not used [-Wunused-but-set-variable]
>     2861 |         int nr_devs;
>          |             ^~~~~~~
> 
> 
> vim +/nr_devs +2861 drivers/pci/probe.c
> 
> bccf90d6e063d2 Palmer Dabbelt  2017-06-23  2841  
> 1c02ea81006548 Mika Westerberg 2017-10-13  2842  /**
> 1c02ea81006548 Mika Westerberg 2017-10-13  2843   * pci_scan_child_bus_extend() - Scan devices below a bus
> 1c02ea81006548 Mika Westerberg 2017-10-13  2844   * @bus: Bus to scan for devices
> 1c02ea81006548 Mika Westerberg 2017-10-13  2845   * @available_buses: Total number of buses available (%0 does not try to
> 1c02ea81006548 Mika Westerberg 2017-10-13  2846   *		     extend beyond the minimal)
> 1c02ea81006548 Mika Westerberg 2017-10-13  2847   *
> 1c02ea81006548 Mika Westerberg 2017-10-13  2848   * Scans devices below @bus including subordinate buses. Returns new
> 1c02ea81006548 Mika Westerberg 2017-10-13  2849   * subordinate number including all the found devices. Passing
> 1c02ea81006548 Mika Westerberg 2017-10-13  2850   * @available_buses causes the remaining bus space to be distributed
> 1c02ea81006548 Mika Westerberg 2017-10-13  2851   * equally between hotplug-capable bridges to allow future extension of the
> 1c02ea81006548 Mika Westerberg 2017-10-13  2852   * hierarchy.
> 1c02ea81006548 Mika Westerberg 2017-10-13  2853   */
> 1c02ea81006548 Mika Westerberg 2017-10-13  2854  static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
> 1c02ea81006548 Mika Westerberg 2017-10-13  2855  					      unsigned int available_buses)
> 1c02ea81006548 Mika Westerberg 2017-10-13  2856  {
> 1c02ea81006548 Mika Westerberg 2017-10-13  2857  	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
> 1c02ea81006548 Mika Westerberg 2017-10-13  2858  	unsigned int start = bus->busn_res.start;
> 5cac6729750b74 Niklas Schnelle 2022-04-12  2859  	unsigned int devfn, cmax, max = start;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2860  	struct pci_dev *dev;
> 690f4304104f37 Jan Kiszka      2018-03-07 @2861  	int nr_devs;
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2862  
> 0207c356ef0e2b Bjorn Helgaas   2009-11-04  2863  	dev_dbg(&bus->dev, "scanning bus\n");
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2864  
> ^1da177e4c3f41 Linus Torvalds  2005-04-16  2865  	/* Go find them, Rover! */
> 5cac6729750b74 Niklas Schnelle 2022-04-12  2866  	for (devfn = 0; devfn < 256; devfn += 8)
> 690f4304104f37 Jan Kiszka      2018-03-07  2867  		nr_devs = pci_scan_slot(bus, devfn);

The bot is right, the nr_devs can be removed as the patch removed the
only read access did so locally already.

